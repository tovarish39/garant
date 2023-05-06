# frozen_string_literal: true

def notify_account
  Send.mes(Text.clear_account)
end

def to_search_user
  Send.mes(Text.search_user, M::Reply.search_user)
end

def get_footer scamer
  case scamer.status
  when 'to_moderator'
    "<b>Статус:</b> ⌛На рассмотрении⌛"
  when 'accepted_complaint' 
    "<b>Статус:</b> Одобрена\n опубликована на канале"
  when 'rejected_complaint' 
    "<b>Статус:</b> ❌Отклонено❌\n #{"<b>Причина:</b> #{scamer.explanation_by_moderator}" if scamer.explanation_by_moderator.present?}"
  end
end

def view_requests
  scamers = $user.scamers.where.not(status:'filling')

  if scamers.any?
    scamers.each do |scamer|
      user_scamer = BlackListUser.find_by(telegram_id:scamer.telegram_id)
      text = """#{Text.complaint(scamer)}\n#{Text.user_info(user_scamer)}\n<strong>Ссылка:</strong>  <a href='#{scamer.telegraph_link}'>telegraph_link</a>\n"""
      text << get_footer(scamer)
      $bot.api.send_message(text:text, chat_id:$mes.chat.id, parse_mode:"HTML")
      # Send.mes(text)
    end
  else
    Send.mes(Text.not_complaints)
  end

end