username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")

Bot_token = ENV['Garant_bot_token']
St_machine = Event_bot.new

# сокращения
CallbackClass  = Telegram::Bot::Types::CallbackQuery
MessageClass   = Telegram::Bot::Types::Message
UpdateMember   = Telegram::Bot::Types::ChatMemberUpdated

RM = ->(keyboard)           {Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard:keyboard, resize_keyboard:true)}
IM = ->(inline_keyboard)    {Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard:inline_keyboard)}
IB = ->(text, callback_data){Telegram::Bot::Types::InlineKeyboardButton.new(text:text, callback_data:callback_data)}
# B - текст от бота
# T - текст кнопок
# IB - inline button
# IM - inline markup
# RM - reply markup

Ru = 'Русский'
En = 'English'

My_chat_id = '1964112204'