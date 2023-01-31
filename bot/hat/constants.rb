username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")

Bot_token = ENV['Garant_bot_token']

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
Choose_language             = "Выберите язык / Choose language"
Send_username_or_id         = {Ru=>'отправьте username или id пользователя', En=>'send username or user id'}
User_not_found              = {Ru=>'Пользователь не найден',                 En=>'User not found'}
Start                       = {Ru=>'Выберите действие из меню',              En=>'Choose action in menu'}
Users_comments              = {Ru=>'Отзывы о пользователе',                  En=>'Users comments'}
Disputs_by_user             = {Ru=>'Споры пользователя',                     En=>'Users disputs'}
Wins                        = {Ru=>'Победные споры пользователя',            En=>'Winning user disputes'}
Losts                       = {Ru=>'Пройгрышные споры пользователя',         En=>'Losing user disputes'}
Choose_action               = {Ru=>'Выберите дейсвие',                       En=>'Choose action'}
Choose_currencies_type      = {Ru=>'Выберите валюту сделки',                 En=>'Choose currency type'}
Push_amount_currency        = {Ru=>'Введите сумму сделки в',                 En=>'Enter the transaction amount in'}
Push_conditions             = {Ru=>'Введите условия сделки',                 En=>'Enter deal conditions'}
Invalid_amount              = {Ru=>'Не валидное число',                      En=>'Invalid amount'}
BT_reject_deal_self         = {Ru=>'Вы отменили сделку',                     En=>'You canceled the deal'}
TB_pending_pay_from_custumer= {Ru=>'Ожидание оплаты покупателем',            En=>'Pending pay by custumer'}

# текст кнопок 
Find_user        = {Ru=>'🔎Найти пользователя🔎',En=>'🔎Find_user🔎'}
Deals            = {Ru=>'🤝Сделки🤝',            En=>'🤝Deals🤝'}
Profile          = {Ru=>'👨‍💼Профиль👨‍💼',           En=>'👨‍💼Profile👨‍💼'}
Help             = {Ru=>'😱Помощь😱',            En=>'😱Help😱'}
Propose_deal     = {Ru=>'Предложить сделку',     En=>'Propose a deal'}
Cancel_to_start  = {Ru=>'Отмена',                En=>'Cancel'}
Comments         = {Ru=>'Отзывы',                En=>'Comments'}
Dispute          = {Ru=>'Споры',                 En=>'Dispute'}
Back             = {Ru=>'Назад',                 En=>'Back'}
Won              = {Ru=>'Выйграл споров',        En=>'Won disputs'}
Lost             = {Ru=>'Проиграл споров',       En=>'Lost disputs'}
Buy              = {Ru=>'Я покупатель',          En=>'I`m custumer'}
Sell             = {Ru=>'Я продавец',            En=>'I`m seller'}
Crypto_currecues = {Ru=>'Криптовалюта',          En=>'Crypto-Currencies'}
Another_currecues= {Ru=>'Другое',                En=>'Another'}
Cancel           = {Ru=>'Отмена',                En=>'Cancel'}
Confirm          = {Ru=>'Подтвердить',           En=>'Confirm'}
Accept           = {Ru=>'Принять',               En=>'Accept'}
Reject           = {Ru=>'Отклонить',             En=>'Reject'}
Pay              = {Ru=>'Оплатить',              En=>'Pay'}

# reply_markups
Start_markup = -> {Reply_M.new(keyboard:[Find_user[$lang], Deals[$lang], [Profile[$lang], Help[$lang]]],   resize_keyboard:true)}

# inline buttons
Russian_inline          =    Inline_B.new(text:Ru,                      callback_data:"#{Ru}/Выбранный язык")
English_inline          =    Inline_B.new(text:En,                      callback_data:"#{En}/Выбранный язык")
Cancel_to_start_inline  = ->{Inline_B.new(text:Cancel_to_start[$lang],  callback_data:"Cancel")}
Propose_deal_inline     = ->{Inline_B.new(text:Propose_deal[$lang],     callback_data:"Предложить сделку")}
Comments_inline         = ->{Inline_B.new(text:Comments[$lang],         callback_data:"Отзывы")}
Dispute_inline          = ->{Inline_B.new(text:Dispute[$lang],          callback_data:"Споры")}
Back_to_user_inline     = ->{Inline_B.new(text:Back[$lang],             callback_data:"Назад к юзеру")}
Won_inline              = ->{Inline_B.new(text:"#{Won[$lang]} (111)",   callback_data:"Выйграл споров")}
Lost_inline             = ->{Inline_B.new(text:"#{Lost[$lang]} (111)",  callback_data:"Проиграл споров")}
Back_to_disputs_inline  = ->{Inline_B.new(text:Back[$lang],             callback_data:"Назад к спорам")}
Buy_inline              = ->{Inline_B.new(text:Buy[$lang],              callback_data:"Я покупатель")}
Sell_inline             = ->{Inline_B.new(text:Sell[$lang],             callback_data:"Я продавец")}
Crypto_urrency_inline   = ->{Inline_B.new(text:Crypto_currecues[$lang], callback_data:"Криптовалюта")}
Another_currency_inline = ->{Inline_B.new(text:Another_currecues[$lang],callback_data:"Другое")}
Back_to_actions_inline  = ->{Inline_B.new(text:Back[$lang],             callback_data:"Назад к действиям")}
Back_to_currency_types  = ->{Inline_B.new(text:Back[$lang],             callback_data:"Назад к типам валют/")}   
Crypto_currecues_inline = ->{Crypto_currecues_array.map {|crypto| Inline_B.new(text:crypto, callback_data:"Валюта сделки/#{crypto}")}}
Cofirm_deal_inline      = ->{Inline_B.new(text:Confirm[$lang],          callback_data:"Подтвердить сделку")}   
Cancel_deal_inline      = ->{Inline_B.new(text:Cancel[$lang],           callback_data:"Назад к юзеру")}


I_accept          = ->(deal){Inline_B.new(text:Accept[$lang],           callback_data:"response_seller to request_by_custumer/Принять/#{deal.id}")}
I_reject          = ->(deal){Inline_B.new(text:Reject[$lang],           callback_data:"response_seller to request_by_custumer/Отклонить/#{deal.id}")}

I_pay             = ->(deal){Inline_B.new(text:Pay[$lang],              callback_data:"response_custumer to request_by_seller/pay/#{deal.id}")}
I_cancel          = ->(deal){Inline_B.new(text:Cancel[$lang],           callback_data:"response_custumer to request_by_seller/cancel deal/#{deal.id}")}

# inline markups
Languages_markup        =    Inline_M.new(inline_keyboard:[[Russian_inline, English_inline]])
Propose_deal_markup     = ->{Inline_M.new(inline_keyboard:[ Propose_deal_inline.call, Comments_inline.call, Dispute_inline.call])}
Cancel_to_start_markup  = ->{Inline_M.new(inline_keyboard:  Cancel_to_start_inline.call)}
Back_to_user_markup     = ->{Inline_M.new(inline_keyboard:  Back_to_user_inline.call)}
Disputs_types_markup    = ->{Inline_M.new(inline_keyboard:[ Won_inline.call, Lost_inline.call, Back_to_user_inline.call])}
Back_to_disputs_markup  = ->{Inline_M.new(inline_keyboard:  Back_to_disputs_inline.call)}
Actions_markup          = ->{Inline_M.new(inline_keyboard:[ Buy_inline.call, Sell_inline.call, Back_to_user_inline.call])}
Currency_type_markup    = ->{Inline_M.new(inline_keyboard:[ Crypto_urrency_inline.call, Another_currency_inline.call, Back_to_actions_inline.call])}
Crypto_currencies_markup= ->{Inline_M.new(inline_keyboard:Crypto_currecues_inline.call << Back_to_currency_types.call)}
Confirm_deal_markup     = ->{Inline_M.new(inline_keyboard:[ Cofirm_deal_inline.call, Cancel_deal_inline.call])}
# M_Accept_reject   = ->(deal){Inline_M.new(inline_keyboard:[ I_Accept.call(deal), I_Reject.call(deal)])}
# M_pay_cancel      = ->(deal){Inline_M.new(inline_keyboard:[ I_pay.call(deal), I_cancel.call(deal)])}

M_accept_reject_by_custumer=->(deal){Inline_M.new(inline_keyboard:[ I_pay.call(deal), I_cancel.call(deal)])}
M_accept_reject_by_seller  =->(deal){Inline_M.new(inline_keyboard:[ I_accept.call(deal), I_reject.call(deal)])}

To_user_info            = -> (to_user, lang){
  return %{
<b>👤Пользователь:</b>
<b>Имя:</b> #{to_user.first_name}
<b>Фамилия:</b> #{to_user.last_name}
<b>username:</b> #{to_user.username}
<b>id:</b> #{to_user.telegram_id}

📈Сделок как покупатель: 0
📉Сделок как продавец: 0
⚖️Споры: 0
📬Отзывы: 0

⭐️Рейтинг: 5/5
  } if lang == Ru
  return %{
<b>User:</b>
<b>First name:</b> #{to_user.first_name}
<b>Last name:</b> #{to_user.last_name}
<b>username:</b> #{to_user.username}
<b>id:</b> #{to_user.telegram_id}

📈Deals how seller: 0
📉Deals how custumer: 0
⚖️Dusputs: 0
📬Comments: 0

⭐️Rating: 5/5
  } if lang == En
}

Confirm_deal            = -> (user, to_user, lang) {
  return %{
Сделка с 
<b>Имя:</b> #{to_user.first_name}
<b>Фамилия:</b> #{to_user.last_name}
<b>username:</b> #{to_user.username}
<b>id:</b> #{to_user.telegram_id}

Условия сделки:
#{user.conditions}

Cумма сделки: <b>#{user.amount} #{user.currency}</b>
Комиссия гаранта: 999
Сумма к оплате: 999
} if lang == Ru 
  return %{
Deal with 
<b>First name:</b> #{to_user.first_name}
<b>Last name:</b> #{to_user.last_name}
<b>username:</b> #{to_user.username}
<b>id:</b> #{to_user.telegram_id}
  
  Conditions:
  #{user.conditions}
  
  Amount: <b>#{user.amount} #{user.currency}</b>
  Comission: 999
  Result amount: 999
}  if lang == En  }

Request_deal = -> (deal_created, lang) {
  return "Запрос на сделкy № <b>#{deal_created.id}</b> успешно отправлен, ожидвайте подтверждения" if lang == Ru
  return "Request to deal № <b>#{deal_created.id}</b> sent successfully, please wait for confirmation" if lang == En
}

Request_deal_to_user = -> (deal, user_from, lang){
  return %{
Предложение <b>#{(user_from.role == 'seller') ? 'продажи' : 'покупки'}</b> от
<b>Имя:</b> #{user_from.first_name}
<b>Фамилия:</b> #{user_from.last_name}
<b>username:</b> #{user_from.username}
<b>id:</b> #{user_from.telegram_id}
<b>Условия сделки:</b> #{deal.conditions}
<b>Сумма сделки:</b> #{deal.amount} #{deal.currency}
<b>Комиссия гаранта:</b>  ---------
<b>Сумма к получению:</b> ---------
  } if lang == Ru
  return %{
Offer <b>#{(user_from.role == 'seller') ? 'to sell' : 'to buy'}</b> from
<b>First name:</b> #{user_from.first_name}
<b>Last name:</b> #{user_from.last_name}
<b>username:</b> #{user_from.username}
<b>id:</b> #{user_from.telegram_id}
<b>Conditions:</b> #{deal.conditions}
<b>Amount:</b> #{deal.amount} #{deal.currency}
<b>Comission:</b>  ---------
<b>Result amount:</b> ---------
  } if lang == En
}

BT_reject_deal_to_from_user = ->(deal, rejected_by_user, lang){
  return %{
Сделка № #{deal.id}
<b>Пользователь</b>
<b>Имя:</b> #{rejected_by_user.first_name}
<b>Фамилия:</b> #{rejected_by_user.last_name}
<b>username:</b> #{rejected_by_user.username}
<b>id:</b> #{rejected_by_user.telegram_id}

Отклонил сделку
  } if lang == Ru
  return %{
Deal № #{deal.id}
<b>User</b>
<b>First name:</b> #{rejected_by_user.first_name}
<b>Last name:</b> #{rejected_by_user.last_name}
<b>username:</b> #{rejected_by_user.username}
<b>id:</b> #{rejected_by_user.telegram_id}

Reject deal
  } if lang == En
}

TB_response_pay = ->(deal, accepted_by_user, lang){
  return %{
Сделка № #{deal.id}
<b>Продавец</b>
<b>Имя:</b> #{accepted_by_user.first_name}
<b>Фамилия:</b> #{accepted_by_user.last_name}
<b>username:</b> #{accepted_by_user.username}
<b>id:</b> #{accepted_by_user.telegram_id}

Принял сделку, чтобы продолжить, передайте средства на храниние гаранту
  } if lang == Ru
  return %{
Deal № #{deal.id}
<b>Seller</b>
<b>First name:</b> #{accepted_by_user.first_name}
<b>Last name:</b> #{accepted_by_user.last_name}
<b>username:</b> #{accepted_by_user.username}
<b>id:</b> #{accepted_by_user.telegram_id}

Accepted the deal, to continue, transfer the funds for safekeeping to the guarant
  } if lang == En
}

TB_notifi_to_seller_success_payed = ->(deal, custumer, lang){
  return %{
Сделка № #{deal.id}
<b>Покупатель</b>
<b>Имя:</b> #{custumer.first_name}
<b>Фамилия:</b> #{custumer.last_name}
<b>username:</b> #{custumer.username}
<b>id:</b> #{custumer.telegram_id}

Принял сделку, средства заморожены на счету гаранта, вы можете передать товар/оказать услугу.
Завершить сделку может покупатель. Если у вас возник спор, то вы можете вызвать модератора, перейдя в раздел "Сделки".
      } if lang == Ru
  return %{
Deal № #{deal.id}
<b>Custumer</b>
<b>First name:</b> #{custumer.first_name}
<b>Last name:</b> #{custumer.last_name}
<b>username:</b> #{custumer.username}
<b>id:</b> #{custumer.telegram_id}

I accepted the deal, the funds are frozen on the account of the guarantor, you can transfer the goods / provide the service.
The buyer can complete the transaction. If you have a dispute, you can call a moderator by going to the "Deals" section.
      } if lang == En
}

TB_notify_to_custumer_success_payed = {Ru=>'Средства переведены на хранение гаранту', En=>'The funds were transferred to the safekeeping of the guarant'}