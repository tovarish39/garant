# frozen_string_literal: true

class StateMachine
  include AASM

  aasm whiny_transitions: false

  aasm do
    before_all_events   :log_before
    after_all_events    :log_after
    error_on_all_events :log_error
  end

  def income_message
    if mes_data?
      "data = #{$mes.data}"
    elsif mes_text?
      "text = #{$mes.text}"
    end
  end

  def log_before
    $logger.info("user_id = #{$user.id} ; FROM_state = #{aasm.current_state} ; #{income_message}")
  end

  def log_after
    $logger.info("user_id = #{$user.id} ; NEW_state  = #{aasm.current_state}")
  end

  def log_error(exception)
    # raise
    $logger.error("ERR ; user_id = #{$user.id} #{exception.backtrace}")
  end
end

def handle
  $user = user_search_and_update_if_changed('BlackListUser')
  $user ||= create_user('BlackListUser')
  $lg = $user.lang


####### group
  if mes_from_group?
    if verify_with_text?
      username = $mes.text.split(' ').last
      verifying_text(username)
    elsif verify_text_only? # если /verify + forwarted
      $user.update(verifying_by_time:Time.now)
    elsif next_forwarted_message?
      $user.update(verifying_by_time:nil)
      verifying_by_forwarted_mes()
    end
##############


  elsif $mes.instance_of?(ChatMemberUpdated) # реагирует только от private chat
  elsif $user.is_blocked_by_moderator
  elsif !user_is_member_of_channel?
    require_subscribe_channel()
  elsif mes_text? || mes_data? || is_user_shared? || mes_photo?
    

    if $lg.nil? # язык ещё не выбран
      $user.update(state_aasm: 'language')
    elsif $user.is_self_scamer 
      state = $user.state_aasm
      $user.update(state_aasm:'scamer') if state != 'scamer' && state != 'justification' 
      # elsif $user.state_aasm == 'scamer' || $user.state_aasm == 'justification' # чтоб не работали ниже условия
    elsif mes_text? && Button.all_main.include?($mes.text) # кнопка главного меню или /start
      $user.update(state_aasm: 'start')
    end


    event_bot = StateMachine.new

    from_state = $user.state_aasm.to_sym          # предидущее состояние
    event_bot.aasm.current_state = from_state

    event_bot.method(action(from_state)).call     # "#{from_state}_action"

    new_state = event_bot.aasm.current_state
    $user.update(state_aasm: new_state)
  end
end


def next_forwarted_message? # в течении 1 секунды
  return false if $user.verifying_by_time.nil?
  $mes.forward_from.present? && ($user.verifying_by_time > (Time.now - 1))  
end

def verify_text_only?
  $mes.text.strip == '/verify'
end

def user_is_member_of_channel?
  res = $bot.api.getChatMember(chat_id: TELEGRAM_CHANNEL_ID, user_id: $mes.from.id)
  status = res['result']['status']
  return true if status == 'member' || status == 'creator' # !'left' !'kicked'
  false
end

def require_subscribe_channel
  Send.mes(Text.require_subscribe_channel)
end

def verify_with_text?
  $mes.text  =~ /^\/verify\s@?\w+/
end


def verifyed_by_administrator? user
  user.status_by_moderator == 'Проверенный'
end

def is_scamer? user
  user.is_self_scamer 
end

def verifying_text raw_username
  clear_username = raw_username.delete('@')
  # puts clear_username
  user = BlackListUser.find_by(username:clear_username)

  if    user.present? && verifyed_by_administrator?(user)
    Send.mes(Text.verifyed raw_username) 
  elsif user.present? && is_scamer?(user)
    complaints = Complaint.where(telegram_id:user.telegram_id).filter {|compl| compl.mes_id_published_in_channel.present?}
    Send.mes(Text.is_scamer raw_username, complaints.first)
  else
    Send.mes(Text.not_scamer raw_username)
  end
end

def verifying_by_forwarted_mes
  user = BlackListUser.find_by(telegram_id:$mes.forward_from.id)
  if    user.present? && verifyed_by_administrator?(user)
    Send.mes(Text.verifyed user.telegram_id) 
  elsif user.present? && is_scamer?(user)
    complaints = Complaint.where(telegram_id:user.telegram_id).filter {|compl| compl.mes_id_published_in_channel.present?}
    Send.mes(Text.is_scamer user.telegram_id, complaints.first)
  else
    Send.mes(Text.not_scamer $mes.forward_from.id)
  end
end