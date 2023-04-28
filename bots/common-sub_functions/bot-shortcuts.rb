# frozen_string_literal: true

def send_message(text, reply_markup = nil)
  $bot.send_message(chat_id: $chat_id, text: text, reply_markup: reply_markup, parse_mode: 'HTML')
end

def send_message_to_user(text, to_user, reply_markup = nil)
  $bot.send_message(chat_id: to_user.telegram_id, text: text, reply_markup: reply_markup, parse_mode: 'HTML')
end

def delete_pushed(message_id = $mes.message.message_id)
  $bot.delete_message(chat_id: $chat_id, message_id: message_id)
end

def delete_text
  $bot.delete_message(chat_id: $chat_id, message_id: $mes.message_id)
end

def edit_message(text, reply_markup = nil, message_id = nil)
  message_id ||= $mes.message.message_id
  $bot.edit_message_text(chat_id: $chat_id, message_id: message_id, text: text, reply_markup: reply_markup,
                         parse_mode: 'HTML')
end
