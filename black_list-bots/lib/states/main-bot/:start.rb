# frozen_string_literal: true

class StateMachine
  aasm do
    state :start
    event :start_action, from: :start do
      transitions if: -> { mes_text?(Button.make_a_complaint) }, after: :to_search_user, to: :search_user
      transitions if: -> { mes_text?(Button.request_status) }  , after: :view_requests , to: :start
      transitions if: -> { mes_text?(Button.account_status) }  , after: :notify_account, to: :start
      transitions if: -> { mes_text?('/start') }               , after: :to_start      , to: :start
    end   
  end
end

def clear_account
  true
end


def notify_account
  # try_puts

  Send.mes(Text.clear_account)
end

def to_search_user
  Send.mes(Text.search_user, M::Reply.search_user)
end

def get_footer complaint
  case complaint.status
  when 'to_moderator'
    "<b>Статус:</b> ⌛На рассмотрении⌛"
  when 'accepted_complaint' 
    "<b>Статус:</b> Одобрена\n опубликована на канале"
  when 'rejected_complaint' 
    "<b>Статус:</b> ❌Отклонено❌\n #{"<b>Причина:</b> #{complaint.explanation_by_moderator}" if complaint.explanation_by_moderator.present?}"
  end
end

def view_requests
  complaints = $user.complaints.with_statuses(['to_moderator', 'accepted_complaint', 'rejected_complaint']) 

  if complaints.any?
    complaints.each do |complaint|
      to_user = BlackListUser.find_by(telegram_id:complaint.telegram_id)
      text = """#{Text.complaint(complaint)}\n#{Text.user_info(to_user)}\n<strong>Ссылка:</strong>  <a href='#{complaint.telegraph_link}'>telegraph_link</a>\n"""
      text << get_footer(complaint)
      $bot.api.send_message(text:text, chat_id:$mes.chat.id, parse_mode:"HTML")
    end
  else
    Send.mes(Text.not_complaints)
  end

end
