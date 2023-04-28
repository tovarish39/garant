# frozen_string_literal: true

require 'telegram/bot'

# сокращения
CallbackClass  = Telegram::Bot::Types::CallbackQuery
MessageClass   = Telegram::Bot::Types::Message
UpdateMember   = Telegram::Bot::Types::ChatMemberUpdated

RM = ->(keyboard)           { Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: keyboard, resize_keyboard: true) }
IM = ->(inline_keyboard)    { Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: inline_keyboard) }
IB = lambda { |text, callback_data|
  Telegram::Bot::Types::InlineKeyboardButton.new(text: text, callback_data: callback_data)
}

token = ENV['BOT_TOKEN']
my_telegram_id   = 1_964_112_204
seva_telegram_id = 6_016_837_864

request_id = 111
UserShared = { request_id: request_id }.freeze

KeyboardButtonRequestUser = { request_id: request_id }.freeze
KeyboardButton = { text: 'textttt', request_user: KeyboardButtonRequestUser }.freeze

def send_message(text, reply_markup = nil)
  $bot.send_message(chat_id: $chat_id, text: text, reply_markup: reply_markup, parse_mode: 'HTML')
end

def send_message_to_user(text, to_user, reply_markup = nil)
  $bot.send_message(chat_id: to_user.telegram_id, text: text, reply_markup: reply_markup, parse_mode: 'HTML')
end

def delete_pushed
  $bot.delete_message(chat_id: $chat_id, message_id: $mes.message.message_id)
end

def delete_text
  $bot.delete_message(chat_id: $chat_id, message_id: $mes.message_id)
end

def edit_message(text, reply_markup = nil, message_id = nil)
  message_id ||= $mes.message.message_id
  $bot.edit_message_text(chat_id: $chat_id, message_id: message_id, text: text, reply_markup: reply_markup,
                         parse_mode: 'HTML')
end
# 8790
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    $bot = bot.api
    $mes = message
    $chat_id = $mes.instance_of?(MessageClass) ? $mes.chat.id : $mes.message.chat.id

    markup = IM.call([IB.call('123', 'data')])

    edit_message('123', nil, '8790')
    if $mes.instance_of?(MessageClass)
      mes = send_message(
        'asd',
        markup
      )
    end
    puts mes
  end
end
