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
    raise
    $logger.error("ERR ; user_id = #{$user.id} #{exception.backtrace}")
  end
end

def handle
  $user = user_search_and_update_if_changed
  $user ||= create_user
  $lg = $user.lang


  if $mes.instance_of?(ChatMemberUpdated)
    # update_is_member
  elsif mes_text? || mes_data? || is_user_shared? || mes_photo?
    if $lg.nil?
      $user.update(state_aasm: 'language')
    elsif mes_text? && Button.all_main.include?($mes.text)
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
