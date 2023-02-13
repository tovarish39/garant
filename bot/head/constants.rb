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

# главное меню
T_find_user        = {Ru=>'🔎Найти пользователя🔎',En=>'🔎Find_user🔎'}
T_deals            = {Ru=>'🤝Сделки🤝',            En=>'🤝Deals🤝'}
T_profile          = {Ru=>'👨‍💼Профиль👨‍💼',           En=>'👨‍💼Profile👨‍💼'}
T_help             = {Ru=>'😱Помощь😱',            En=>'😱Help😱'}


T_start_actions = [
  T_find_user[Ru], T_find_user[En],
  T_deals[Ru],     T_deals[En],
  T_profile[Ru],   T_profile[En],
  T_help[Ru],      T_help[En],
  '/start'
]


# Crypto_currecues_array = ['BTC', 'ETH']

# # сообщения бота
B_choose_language             = "Выберите язык / Choose language"
B_start                       = {Ru=>'Выберите действие из меню',              En=>'Choose action in menu'}
B_await_username_or_id        = {Ru=>'отправьте username или id пользователя', En=>'send username or user id'}
B_userTo_not_found            = {Ru=>'Пользователь не найден',                 En=>'User not found'}
B_userTo_comments             = {Ru=>'Отзывы о пользователе',                  En=>'Users comments'}
B_disputs_by_userTo           = {Ru=>'Споры пользователя',                     En=>'Users disputs'}
# Wins                        = {Ru=>'Победные споры пользователя',            En=>'Winning user disputes'}
# Losts                       = {Ru=>'Пройгрышные споры пользователя',         En=>'Losing user disputes'}
# Choose_action               = {Ru=>'Выберите дейсвие',                       En=>'Choose action'}
# Choose_currencies_type      = {Ru=>'Выберите валюту сделки',                 En=>'Choose currency type'}
# Push_amount_currency        = {Ru=>'Введите сумму сделки в',                 En=>'Enter the transaction amount in'}
# Push_conditions             = {Ru=>'Введите условия сделки',                 En=>'Enter deal conditions'}
# Invalid_amount              = {Ru=>'Не валидное число',                      En=>'Invalid amount'}
# BT_reject_deal_self         = {Ru=>'Вы отменили сделку',                     En=>'You canceled the deal'}
# TB_pending_pay_from_custumer= {Ru=>'Ожидание оплаты покупателем',            En=>'Pending pay by custumer'}

# # текст кнопок 
T_cancel           = {Ru=>'Отмена',                En=>'Cancel'}
T_offer_deal       = {Ru=>'Предложить сделку',     En=>'Offer a deal'}
T_comments         = {Ru=>'Отзывы',                En=>'Comments'}
T_disputes         = {Ru=>'Споры',                 En=>'Disputes'}
T_back             = {Ru=>'Назад',                 En=>'Back'}
T_won_disputs      = {Ru=>'Выйграл споров',        En=>'Won disputs'}
T_lost_disputs     = {Ru=>'Проиграл споров',       En=>'Lost disputs'}
# Buy              = {Ru=>'Я покупатель',          En=>'I`m custumer'}
# Sell             = {Ru=>'Я продавец',            En=>'I`m seller'}
# Crypto_currecues = {Ru=>'Криптовалюта',          En=>'Crypto-Currencies'}
# Another_currecues= {Ru=>'Другое',                En=>'Another'}
# Cancel           = {Ru=>'Отмена',                En=>'Cancel'}
# Confirm          = {Ru=>'Подтвердить',           En=>'Confirm'}
# Accept           = {Ru=>'Принять',               En=>'Accept'}
# Reject           = {Ru=>'Отклонить',             En=>'Reject'}
# Pay              = {Ru=>'Оплатить',              En=>'Pay'}

# # reply_markups
RM_start = -> {RM.call([T_find_user[$lang], T_deals[$lang], [T_profile[$lang], T_help[$lang]]])}

# # inline buttons
# :language
IB_rus                    =             IB.call( Ru,                       "#{Ru}/Выбранный язык")
IB_en                     =             IB.call( En,                       "#{En}/Выбранный язык")
# :await_userTo_data
IB_cancel_to_start        = ->         {IB.call( T_cancel[$lang],          "Cancel"              )}
# UserToActions
IB_offer_deal             = ->(userTo) {IB.call( T_offer_deal[$lang],      "Offer_deal/#{            userTo.id}")}
IB_comments               = ->(userTo) {IB.call( T_comments[$lang],        "Comments/#{              userTo.id}")}
IB_disputes               = ->(userTo) {IB.call( T_disputes[$lang],        "Disputs/#{               userTo.id}")}
# TypeOfDisputs Comments
IB_back_to_userTo_actions = ->(userTo) {IB.call( T_back[$lang],                  "Back_to userTo_actions/#{userTo.id}")}
# TypeOfDisputs
IB_won_disputs             = ->(userTo) {IB.call("#{T_won_disputs[$lang]} (111)",  "Won_disputs/#{ userTo.id}")}
IB_lost_disputs            = ->(userTo) {IB.call("#{T_lost_disputs[$lang]} (111)", "Lost_disputs/#{userTo.id}")}
# WonDisputs LostDisputs
IB_back_to_type_of_disputs = ->(userTo) {IB.call( T_back[$lang],            "Back_to TypeOfDisputs/#{userTo.id}")}

# Buy_inline              = ->{Inline_B.new(text:Buy[$lang],              callback_data:"Я покупатель")}
# Sell_inline             = ->{Inline_B.new(text:Sell[$lang],             callback_data:"Я продавец")}
# Crypto_urrency_inline   = ->{Inline_B.new(text:Crypto_currecues[$lang], callback_data:"Криптовалюта")}
# Another_currency_inline = ->{Inline_B.new(text:Another_currecues[$lang],callback_data:"Другое")}
# Back_to_actions_inline  = ->{Inline_B.new(text:Back[$lang],             callback_data:"Назад к действиям")}
# Back_to_currency_types  = ->{Inline_B.new(text:Back[$lang],             callback_data:"Назад к типам валют/")}   
# Crypto_currecues_inline = ->{Crypto_currecues_array.map {|crypto| Inline_B.new(text:crypto, callback_data:"Валюта сделки/#{crypto}")}}
# Cofirm_deal_inline      = ->{Inline_B.new(text:Confirm[$lang],          callback_data:"Подтвердить сделку")}   
# Cancel_deal_inline      = ->{Inline_B.new(text:Cancel[$lang],           callback_data:"Назад к юзеру")}


# I_accept          = ->(deal){Inline_B.new(text:Accept[$lang],           callback_data:"response_seller to request_by_custumer/Принять/#{deal.id}")}
# I_reject          = ->(deal){Inline_B.new(text:Reject[$lang],           callback_data:"response_seller to request_by_custumer/Отклонить/#{deal.id}")}

# I_pay             = ->(deal){Inline_B.new(text:Pay[$lang],              callback_data:"response_custumer to request_by_seller/pay/#{deal.id}")}
# I_cancel          = ->(deal){Inline_B.new(text:Cancel[$lang],           callback_data:"response_custumer to request_by_seller/cancel deal/#{deal.id}")}

# # inline markups
IM_languages               =              IM.call([[IB_rus, IB_en]])
IM_cancel_to_start         = ->         { IM.call(  IB_cancel_to_start.call)}
IM_offer_deal              = ->(userTo) { IM.call([ IB_offer_deal.call(userTo), IB_comments.call(userTo), IB_disputes.call(userTo)])}
IM_back_to_userTo_actions  = ->(userTo) { IM.call(  IB_back_to_userTo_actions.call(userTo))}
IM_type_of_disputs         = ->(userTo) { IM.call([ IB_won_disputs.call(userTo), IB_lost_disputs.call(userTo), IB_back_to_userTo_actions.call(userTo)])}
IM_back_to_type_of_disputs = ->(userTo) { IM.call(  IB_back_to_type_of_disputs.call(userTo))}
# Actions_markup          = ->{Inline_M.new(inline_keyboard:[ Buy_inline.call, Sell_inline.call, Back_to_user_inline.call])}
# Currency_type_markup    = ->{Inline_M.new(inline_keyboard:[ Crypto_urrency_inline.call, Another_currency_inline.call, Back_to_actions_inline.call])}
# Crypto_currencies_markup= ->{Inline_M.new(inline_keyboard:Crypto_currecues_inline.call << Back_to_currency_types.call)}
# Confirm_deal_markup     = ->{Inline_M.new(inline_keyboard:[ Cofirm_deal_inline.call, Cancel_deal_inline.call])}
# # M_Accept_reject   = ->(deal){Inline_M.new(inline_keyboard:[ I_Accept.call(deal), I_Reject.call(deal)])}
# # M_pay_cancel      = ->(deal){Inline_M.new(inline_keyboard:[ I_pay.call(deal), I_cancel.call(deal)])}

# M_accept_reject_by_custumer=->(deal){Inline_M.new(inline_keyboard:[ I_pay.call(deal), I_cancel.call(deal)])}
# M_accept_reject_by_seller  =->(deal){Inline_M.new(inline_keyboard:[ I_accept.call(deal), I_reject.call(deal)])}
B_user               = {Ru=>"👤Пользователь:",          En=>"👤User:"}
B_first_name         = {Ru=>"Имя:",                     En=>"First name:"}
B_last_name          = {Ru=>"Фамилия:",                 En=>"Last name:"}
B_username           = {Ru=>"username:",                En=>"username:"}
B_user_id            = {Ru=>"id:",                      En=>"id:"}
B_deals_how_seller   = {Ru=>"📈Сделок как покупатель:", En=>"📈Deals how seller:"}
B_deals_how_custumer = {Ru=>"📉Deals how custumer",     En=>"📉Deals how custumer"}
B_dusputs            = {Ru=>"⚖️Dusputs:",                En=>"⚖️Dusputs:"}
B_comments           = {Ru=>"📬Comments:",              En=>"📬Comments:"}
B_rating             = {Ru=>"⭐️Rating:",                En=>"⭐️Rating:"}

B_userTo_info = -> (userTo){
  text = ""
  text << "<b>#{B_user[$lang]}</b>" << "\n"
  text << "<b>#{B_first_name[$lang]}</b> #{userTo.first_name}"   << "\n" if userTo.first_name != '-'
  text << "<b>#{B_last_name[$lang]}</b> #{userTo.last_name}"   << "\n" if userTo.last_name != '-'
  text << "<b>#{B_username[$lang]}</b> #{userTo.username}"  << "\n" if userTo.username != '-'
  text << "<b>#{B_user_id[$lang]}</b> #{userTo.telegram_id}"  << "\n"
  text << "\n"
  text << "<b>#{B_deals_how_seller[$lang]}</b> 0"  << "\n"
  text << "<b>#{B_deals_how_custumer[$lang]}</b> 0"  << "\n"
  text << "<b>#{B_dusputs[$lang]}</b> 0"  << "\n"
  text << "<b>#{B_comments[$lang]}</b> 0"  << "\n"
  text << "\n"
  text << "<b>#{B_rating[$lang]}</b> 5/5"  << "\n"
  text
}

# Confirm_deal            = -> (user, to_user, lang) {
#   return %{
# Сделка с 
# <b>Имя:</b> #{to_user.first_name}
# <b>Фамилия:</b> #{to_user.last_name}
# <b>username:</b> #{to_user.username}
# <b>id:</b> #{to_user.telegram_id}

# Условия сделки:
# #{user.conditions}

# Cумма сделки: <b>#{user.amount} #{user.currency}</b>
# Комиссия гаранта: 999
# Сумма к оплате: 999
# } if lang == Ru 
#   return %{
# Deal with 
# <b>First name:</b> #{to_user.first_name}
# <b>Last name:</b> #{to_user.last_name}
# <b>username:</b> #{to_user.username}
# <b>id:</b> #{to_user.telegram_id}
  
#   Conditions:
#   #{user.conditions}
  
#   Amount: <b>#{user.amount} #{user.currency}</b>
#   Comission: 999
#   Result amount: 999
# }  if lang == En  }

# Request_deal = -> (deal_created, lang) {
#   return "Запрос на сделкy № <b>#{deal_created.id}</b> успешно отправлен, ожидвайте подтверждения" if lang == Ru
#   return "Request to deal № <b>#{deal_created.id}</b> sent successfully, please wait for confirmation" if lang == En
# }

# Request_deal_to_user = -> (deal, user_from, lang){
#   return %{
# Предложение <b>#{(user_from.role == 'seller') ? 'продажи' : 'покупки'}</b> от
# <b>Имя:</b> #{user_from.first_name}
# <b>Фамилия:</b> #{user_from.last_name}
# <b>username:</b> #{user_from.username}
# <b>id:</b> #{user_from.telegram_id}
# <b>Условия сделки:</b> #{deal.conditions}
# <b>Сумма сделки:</b> #{deal.amount} #{deal.currency}
# <b>Комиссия гаранта:</b>  ---------
# <b>Сумма к получению:</b> ---------
#   } if lang == Ru
#   return %{
# Offer <b>#{(user_from.role == 'seller') ? 'to sell' : 'to buy'}</b> from
# <b>First name:</b> #{user_from.first_name}
# <b>Last name:</b> #{user_from.last_name}
# <b>username:</b> #{user_from.username}
# <b>id:</b> #{user_from.telegram_id}
# <b>Conditions:</b> #{deal.conditions}
# <b>Amount:</b> #{deal.amount} #{deal.currency}
# <b>Comission:</b>  ---------
# <b>Result amount:</b> ---------
#   } if lang == En
# }

# BT_reject_deal_to_from_user = ->(deal, rejected_by_user, lang){
#   return %{
# Сделка № #{deal.id}
# <b>Пользователь</b>
# <b>Имя:</b> #{rejected_by_user.first_name}
# <b>Фамилия:</b> #{rejected_by_user.last_name}
# <b>username:</b> #{rejected_by_user.username}
# <b>id:</b> #{rejected_by_user.telegram_id}

# Отклонил сделку
#   } if lang == Ru
#   return %{
# Deal № #{deal.id}
# <b>User</b>
# <b>First name:</b> #{rejected_by_user.first_name}
# <b>Last name:</b> #{rejected_by_user.last_name}
# <b>username:</b> #{rejected_by_user.username}
# <b>id:</b> #{rejected_by_user.telegram_id}

# Reject deal
#   } if lang == En
# }

# TB_response_pay = ->(deal, accepted_by_user, lang){
#   return %{
# Сделка № #{deal.id}
# <b>Продавец</b>
# <b>Имя:</b> #{accepted_by_user.first_name}
# <b>Фамилия:</b> #{accepted_by_user.last_name}
# <b>username:</b> #{accepted_by_user.username}
# <b>id:</b> #{accepted_by_user.telegram_id}

# Принял сделку, чтобы продолжить, передайте средства на храниние гаранту
#   } if lang == Ru
#   return %{
# Deal № #{deal.id}
# <b>Seller</b>
# <b>First name:</b> #{accepted_by_user.first_name}
# <b>Last name:</b> #{accepted_by_user.last_name}
# <b>username:</b> #{accepted_by_user.username}
# <b>id:</b> #{accepted_by_user.telegram_id}

# Accepted the deal, to continue, transfer the funds for safekeeping to the guarant
#   } if lang == En
# }

# TB_notifi_to_seller_success_payed = ->(deal, custumer, lang){
#   return %{
# Сделка № #{deal.id}
# <b>Покупатель</b>
# <b>Имя:</b> #{custumer.first_name}
# <b>Фамилия:</b> #{custumer.last_name}
# <b>username:</b> #{custumer.username}
# <b>id:</b> #{custumer.telegram_id}

# Принял сделку, средства заморожены на счету гаранта, вы можете передать товар/оказать услугу.
# Завершить сделку может покупатель. Если у вас возник спор, то вы можете вызвать модератора, перейдя в раздел "Сделки".
#       } if lang == Ru
#   return %{
# Deal № #{deal.id}
# <b>Custumer</b>
# <b>First name:</b> #{custumer.first_name}
# <b>Last name:</b> #{custumer.last_name}
# <b>username:</b> #{custumer.username}
# <b>id:</b> #{custumer.telegram_id}

# I accepted the deal, the funds are frozen on the account of the guarantor, you can transfer the goods / provide the service.
# The buyer can complete the transaction. If you have a dispute, you can call a moderator by going to the "Deals" section.
#       } if lang == En
# }

# TB_notify_to_custumer_success_payed = {Ru=>'Средства переведены на хранение гаранту', En=>'The funds were transferred to the safekeeping of the guarant'}