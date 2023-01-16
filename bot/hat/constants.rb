username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/transactions_development")

Bot_token = ENV['Transactions_bot_token']

Choose_language =  "Выберите язык / Choose language"

# сокращения
Inline_B = Telegram::Bot::Types::InlineKeyboardButton
Inline_M = Telegram::Bot::Types::InlineKeyboardMarkup
Reply_M  = Telegram::Bot::Types::ReplyKeyboardMarkup
Callback = Telegram::Bot::Types::CallbackQuery
Message  = Telegram::Bot::Types::Message

Ru = 'Русский'
En = 'English'

# сообщения бота
Send_username_or_id = {Ru=>'отправьте username или id пользователя', En=>'send username or user id'}
User_not_found      = {Ru=>'Пользователь не найден',                 En=>'User not found'}
User_data           = {Ru=>'Данные пользователя:',                   En=>'User data:'}
Start               = {Ru=>'Выберите действие из меню',              En=>'Choose action in menu'}

# текст кнопок reply
Propose_dial = {Ru=>'Предложить сделку', En=>'Propose a deal'}
Dials        = {Ru=>'Сделки',            En=>'Dials'}
Profile      = {Ru=>'Профиль',           En=>'Profile'}
Help         = {Ru=>'Помощь',            En=>'Help'}
Cancel       = {Ru=>'Отмена',            En=>'Cancel'}

# текст кнопок inline

# reply_markups
Start_markup = -> {Reply_M.new(keyboard:[Propose_dial[$lang], Dials[$lang], [Profile[$lang], Help[$lang]]],   resize_keyboard:true)}
Cancel_markup = ->{Reply_M.new(keyboard:Cancel[$lang],   resize_keyboard:true)}

# inline buttons
Propose_dial_inline = ->{Inline_B.new(text:Propose_dial[$lang], callback_data:"#{$user.id}/Предложить сделку")}
Russian_inline =         Inline_B.new(text:Ru, callback_data:"#{Ru}/Выбранный язык")
English_inline =         Inline_B.new(text:En, callback_data:"#{En}/Выбранный язык")

# inline markups
Propose_dial_markup = ->{Inline_M.new(inline_keyboard:Propose_dial_inline.call)}
Languages_markup =  Inline_M.new(inline_keyboard:[[Russian_inline, English_inline]])