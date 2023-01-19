username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")

Bot_token = ENV['Garant_bot_token']

Default_filling = {
  'pending'   =>'nil',
  'to_user_id'=>'nil',
  'role'      =>'nil',
  'currency'  =>'nil',
  'amount'    =>'nil',
  'conditions'=>'nil',
  'counter'   =>'nil'
}

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
Choose_language         = "Выберите язык / Choose language"
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
Push_conditions         = {Ru=>'Введите условия сделки',                 En=>'Enter deal conditions'}
Invalid_amount          = {Ru=>'Не валидное число',                      En=>'Invalid amount'}
Confirm_deal            = -> (user, to_user, lang) {
   return %{
Сделка с 
Имя Фамилия
#{to_user.username}
#{to_user.telegram_id}

Условия сделки:
#{user.filling['conditions']}

Cумма сделки: <b>#{user.filling['amount']} #{user.filling['currency']}</b>
Комиссия гаранта: 999
Сумма к оплате: 999
} if lang == Ru 


                    return %{
  Deal with 
  name last name
  #{to_user.username}
  #{to_user.telegram_id}
  
  Conditions:
  #{user.filling['conditions']}
  
  Amount: <b>#{user.filling['amount']} #{user.filling['currency']}</b>
  Comission: 999
  Result amount: 999
}  if lang == En  }
Request_deal = -> (deal_created, lang) {
  return "Запрос на сделкy <b>#{deal_created.id}</b> успешно отправлен, ожидвайте подтверждения" if lang == Ru
  return "Request to deal <b>#{deal_created.id}</b> sent successfully, please wait for confirmation" if lang == En
}


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
Cancel           = {Ru=>'Отмена',            En=>'Cancel'}
Confirm          = {Ru=>'Подтвердить',       En=>'Confirm'}

# reply_markups
Start_markup = -> {Reply_M.new(keyboard:[Find_user[$lang], Deals[$lang], [Profile[$lang], Help[$lang]]],   resize_keyboard:true)}

# inline buttons
Russian_inline          =    Inline_B.new(text:Ru,                      callback_data:"#{Ru}/Выбранный язык")
English_inline          =    Inline_B.new(text:En,                      callback_data:"#{En}/Выбранный язык")
Cancel_to_start_inline  = ->(next_mes_id){Inline_B.new(text:Cancel_to_start[$lang],  callback_data:"Cancel")}
Propose_deal_inline     = ->(next_mes_id){Inline_B.new(text:Propose_deal[$lang],     callback_data:             "Предложить сделку/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Comments_inline         = ->(next_mes_id){Inline_B.new(text:Comments[$lang],         callback_data:                        "Отзывы/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Dispute_inline          = ->(next_mes_id){Inline_B.new(text:Dispute[$lang],          callback_data:                         "Споры/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Back_to_user_inline     = ->(next_mes_id){Inline_B.new(text:Back[$lang],             callback_data:                 "Назад к юзеру/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Won_inline              = ->(next_mes_id){Inline_B.new(text:"#{Won[$lang]} (111)",   callback_data:                "Выйграл споров/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Lost_inline             = ->(next_mes_id){Inline_B.new(text:"#{Lost[$lang]} (111)",  callback_data:               "Проиграл споров/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Back_to_disputs_inline  = ->(next_mes_id){Inline_B.new(text:Back[$lang],             callback_data:                "Назад к спорам/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Buy_inline              = ->(next_mes_id){Inline_B.new(text:Buy[$lang],              callback_data:                        "Купить/#{$to_user_id}/Order/nil/nil/#{next_mes_id}")}
Sell_inline             = ->(next_mes_id){Inline_B.new(text:Sell[$lang],             callback_data:                       "Продать/#{$to_user_id}/Seller/nil/nil/#{next_mes_id}")}
Crypto_urrency_inline   = ->(next_mes_id){Inline_B.new(text:Crypto_currecues[$lang], callback_data:                 "Криптовалюта/#{$to_user_id}/#{$user.filling['role']}/nil/nil/#{next_mes_id}")}
Another_currency_inline = ->(next_mes_id){Inline_B.new(text:Another_currecues[$lang],callback_data:                       "Другое/#{$to_user_id}/#{$user.filling['role']}/nil/nil/#{next_mes_id}")}
Back_to_actions_inline  = ->(next_mes_id){Inline_B.new(text:Back[$lang],             callback_data:            "Назад к действиям/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}
Back_to_currency_types  = ->(next_mes_id){Inline_B.new(text:Back[$lang],             callback_data:          "Назад к типам валют/#{$to_user_id}/#{$user.filling['role']}/nil/nil/#{next_mes_id}")}   
Crypto_currecues_inline = ->(next_mes_id){Crypto_currecues_array.map {|crypto| Inline_B.new(text:crypto, callback_data:"Валюта сделки/#{$to_user_id}/#{$user.filling['role']}/#{crypto}/#{next_mes_id}")}}
Cofirm_deal_inline      = ->(next_mes_id){Inline_B.new(text:Confirm[$lang],          callback_data:          "Подтвердить сделку/#{$to_user_id}/#{$user.filling['role']}/#{next_mes_id}")}   
Cancel_deal_inline      = ->(next_mes_id){Inline_B.new(text:Cancel[$lang],           callback_data:                "Назад к юзеру/#{$to_user_id}/nil/nil/nil/#{next_mes_id}")}

# inline markups
Languages_markup        =    Inline_M.new(inline_keyboard:[[Russian_inline, English_inline]])
Propose_deal_markup     = ->(next_mes_id){Inline_M.new(inline_keyboard:[ Propose_deal_inline.call(next_mes_id), Comments_inline.call(next_mes_id), Dispute_inline.call(next_mes_id)])}
Cancel_to_start_markup  = ->(next_mes_id){Inline_M.new(inline_keyboard:  Cancel_to_start_inline.call(next_mes_id))}
Back_to_user_markup     = ->(next_mes_id){Inline_M.new(inline_keyboard:  Back_to_user_inline.call(next_mes_id))}
Disputs_markup          = ->(next_mes_id){Inline_M.new(inline_keyboard:[ Won_inline.call(next_mes_id), Lost_inline.call(next_mes_id), Back_to_user_inline.call(next_mes_id)])}
Back_to_disputs_markup  = ->(next_mes_id){Inline_M.new(inline_keyboard:  Back_to_disputs_inline.call(next_mes_id))}
Actions_markup          = ->(next_mes_id){Inline_M.new(inline_keyboard:[ Buy_inline.call(next_mes_id), Sell_inline.call(next_mes_id), Back_to_user_inline.call(next_mes_id)])}
Currency_type_markup    = ->(next_mes_id){Inline_M.new(inline_keyboard:[ Crypto_urrency_inline.call(next_mes_id), Another_currency_inline.call(next_mes_id), Back_to_actions_inline.call(next_mes_id)])}
Crypto_currencies_markup= ->(next_mes_id){Inline_M.new(inline_keyboard:Crypto_currecues_inline.call(next_mes_id) << Back_to_currency_types.call(next_mes_id))}
Confirm_deal_markup     = ->(next_mes_id){Inline_M.new(inline_keyboard:[ Cofirm_deal_inline.call(next_mes_id), Cancel_deal_inline.call(next_mes_id)])}
