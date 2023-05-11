# frozen_string_literal: true

def notify_account
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