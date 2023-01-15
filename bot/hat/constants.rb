username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/transactions_development")

Bot_token = ENV['Notebook_bot_token']

# сокращения
Inline_B = Telegram::Bot::Types::InlineKeyboardButton
Inline_M = Telegram::Bot::Types::InlineKeyboardMarkup
Reply_M  = Telegram::Bot::Types::ReplyKeyboardMarkup
Callback = Telegram::Bot::Types::CallbackQuery
Message  = Telegram::Bot::Types::Message

Ru = 'Russian'
En = 'English'

# текст кнопок reply
Propose_dial = {Ru=>'Предложить сделку', En=>'Propose a deal'}



# сообщения бота
Send_username_or_id = {Ru=>'отправьте username или id пользователя', En=>'send username or user id'}
User_not_found      = {Ru=>'Пользователь не найден',                 En=>'User not found'}
User_data           = {Ru=>'Данные пользователя:',                   En=>'User data:'}

# текст кнопок inline


# reply_markups
Start_markup = -> {Reply_M.new(keyboard:Propose_dial[$lang],   resize_keyboard:true)}

# inline buttons
Propose_dial_inline = ->{Inline_B.new(text:Propose_dial[$lang], callback_data:"#{$user.id}/Предложить сделку")}

# inline markups
Propose_dial_markup = ->{Inline_M.new(inline_keyboard:Propose_dial_inline.call)}