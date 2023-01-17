username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")

Bot_token = ENV['Garant_bot_token']

Choose_language =  "Выберите язык / Choose language"

# сокращения
Inline_B = Telegram::Bot::Types::InlineKeyboardButton
Inline_M = Telegram::Bot::Types::InlineKeyboardMarkup
Reply_M  = Telegram::Bot::Types::ReplyKeyboardMarkup
Callback = Telegram::Bot::Types::CallbackQuery
Message  = Telegram::Bot::Types::Message

Ru = 'Русский'
En = 'English'

Crypto_currecues_array = ['BTC', 'ETH']

# сообщения бота
Send_username_or_id     = {Ru=>'отправьте username или id пользователя', En=>'send username or user id'}
User_not_found          = {Ru=>'Пользователь не найден',                 En=>'User not found'}
Start                   = {Ru=>'Выберите действие из меню',              En=>'Choose action in menu'}
Users_comments          = {Ru=>'Отзывы о пользователе',                  En=>'Users comments'}
Disputs_by_user         = {Ru=>'Споры пользователя',                     En=>'Users disputs'}
Wins                    = {Ru=>'Победные споры пользователя',            En=>'Winning user disputes'}
Losts                   = {Ru=>'Пройгрышные споры пользователя',         En=>'Losing user disputes'}
Choose_action           = {Ru=>'Выберите дейсвие',                       En=>'Choose action'}
Choose_currencies_type  = {Ru=>'Выберите валюту сделки',                 En=>'Choose currency type'}
Push_amount_currency    = {Ru=>'Введите сумму сделки в',                 En=>'Enter the transaction amount in'}

# текст кнопок 
Find_user        = {Ru=>'Найти пользователя',En=>'Find_user'}
Propose_deal     = {Ru=>'Предложить сделку', En=>'Propose a deal'}
Deals            = {Ru=>'Сделки',            En=>'Deals'}
Profile          = {Ru=>'Профиль',           En=>'Profile'}
Help             = {Ru=>'Помощь',            En=>'Help'}
Cancel_to_start  = {Ru=>'Отмена',            En=>'Cancel'}
Comments         = {Ru=>'Отзывы',            En=>'Comments'}
Dispute          = {Ru=>'Споры',             En=>'Dispute'}
Back             = {Ru=>'Назад',             En=>'Back'}
Won              = {Ru=>'Выйграл споров',    En=>'Won disputs'}
Lost             = {Ru=>'Проиграл споров',   En=>'Lost disputs'}
Buy              = {Ru=>'Купить',            En=>'Buy'}
Sell             = {Ru=>'Продать',           En=>'Sell'}
Crypto_currecues = {Ru=>'Криптовалюта',      En=>'Crypto-Currencies'}
Another_currecues= {Ru=>'Другое',            En=>'Another'}


# reply_markups
Start_markup = -> {Reply_M.new(keyboard:[Find_user[$lang], Deals[$lang], [Profile[$lang], Help[$lang]]],   resize_keyboard:true)}

# inline buttons
Russian_inline          =    Inline_B.new(text:Ru,                      callback_data:"#{Ru}/Выбранный язык")
English_inline          =    Inline_B.new(text:En,                      callback_data:"#{En}/Выбранный язык")
Cancel_to_start_inline  = ->{Inline_B.new(text:Cancel_to_start[$lang],  callback_data:"Cancel")}
Propose_deal_inline     = ->{Inline_B.new(text:Propose_deal[$lang],     callback_data:"#{$to_user.id}/Предложить сделку")}
Comments_inline         = ->{Inline_B.new(text:Comments[$lang],         callback_data:"#{$to_user.id}/Отзывы")}
Dispute_inline          = ->{Inline_B.new(text:Dispute[$lang],          callback_data:"#{$to_user.id}/Споры")}
Back_to_user_inline     = ->{Inline_B.new(text:Back[$lang],             callback_data:"#{$to_user.id}/Назад к выбранному ранее юзеру")}
Won_inline              = ->{Inline_B.new(text:"#{Won[$lang]} (111)",   callback_data:"#{$to_user.id}/Выйграл споров")}
Lost_inline             = ->{Inline_B.new(text:"#{Lost[$lang]} (111)",  callback_data:"#{$to_user.id}/Проиграл споров")}
Back_to_disputs_inline  = ->{Inline_B.new(text:Back[$lang],             callback_data:"#{$to_user.id}/Назад к спорам")}
Buy_inline              = ->{Inline_B.new(text:Buy[$lang],              callback_data:"#{$to_user.id}/Купить")}
Sell_inline             = ->{Inline_B.new(text:Sell[$lang],             callback_data:"#{$to_user.id}/Продать")}
Crypto_urrency_inline   = ->{Inline_B.new(text:Crypto_currecues[$lang], callback_data:"#{$to_user.id}/Криптовалюта")}
Another_currency_inline = ->{Inline_B.new(text:Another_currecues[$lang],callback_data:"#{$to_user.id}/Другое")}
Back_to_actions_inline  = ->{Inline_B.new(text:Back[$lang],             callback_data:"#{$to_user.id}/Назад к действиям")}
Back_to_currency_types  = ->{Inline_B.new(text:Back[$lang],             callback_data:"#{$to_user.id}/Назад к типам валют")}   
Crypto_currecues_inline = ->{Crypto_currecues_array.map {|crypto| Inline_B.new(text:crypto, callback_data:"#{$to_user.id}/#{crypto}/Валюта сделки")}}
 
# inline markups
Languages_markup        =    Inline_M.new(inline_keyboard:[[Russian_inline, English_inline]])
Propose_deal_markup     = ->{Inline_M.new(inline_keyboard:[ Propose_deal_inline.call, Comments_inline.call, Dispute_inline.call])}
Cancel_to_start_markup  = ->{Inline_M.new(inline_keyboard:  Cancel_to_start_inline.call)}
Back_to_user_markup     = ->{Inline_M.new(inline_keyboard:  Back_to_user_inline.call)}
Disputs_markup          = ->{Inline_M.new(inline_keyboard:[ Won_inline.call, Lost_inline.call, Back_to_user_inline.call])}
Back_to_disputs_markup  = ->{Inline_M.new(inline_keyboard:  Back_to_disputs_inline.call)}
Actions_markup          = ->{Inline_M.new(inline_keyboard:[ Buy_inline.call, Sell_inline.call, Back_to_user_inline.call])}
Currency_type_markup    = ->{Inline_M.new(inline_keyboard:[ Crypto_urrency_inline.call, Another_currency_inline.call, Back_to_actions_inline.call])}
# Crypto_currencies_markup= ->{Inline_M.new(inline_keyboard:Crypto_currecues_inline << )}
# Push_amount_markup      = ->{Inline_M.new(inline_keyboard:[ Buy_inline.call, Sell_inline.call, Back_to_user_inline.call])}