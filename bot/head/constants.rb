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
T_deals            = {Ru=>'🤝Сделки🤝',            En=>'🤝Deals🤝'    }
T_profile          = {Ru=>'👨‍💼Профиль👨‍💼',           En=>'👨‍💼Profile👨‍💼'  }
T_help             = {Ru=>'😱Помощь😱',            En=>'😱Help😱'     }


T_start_actions = [
  T_find_user[Ru], T_find_user[En],
  T_deals[Ru],     T_deals[En],
  T_profile[Ru],   T_profile[En],
  T_help[Ru],      T_help[En],
  '/start'
]


Arr_cryptoCurrecues = ['BTC', 'ETH']

# # сообщения бота
B_choose_language       = "Выберите язык / Choose language"
B_start                 = {Ru=>'Выберите действие из меню',              En=>'Choose action in menu'}
B_await_username_or_id  = {
  Ru=>'Отправьте username или id пользователя или выберите из списка контактов, нажав на кнопку',
  En=>'Send username or user id or select from the contact list by clicking on the button'
}
B_userTo_not_found      = {Ru=>'Пользователь не найден',                 En=>'User not found'}
B_userTo_not_subscr     = {Ru=>"Пользователь не подписан на бота",       En=>"The user is not subscribed to the bot"}
B_userTo_comments       = {Ru=>'Отзывы о пользователе',                  En=>'Users comments'}
B_disputs_by_userTo     = {Ru=>'Споры пользователя',                     En=>'Users disputs'}
# Wins                  = {Ru=>'Победные споры пользователя',            En=>'Winning user disputes'}
# Losts                 = {Ru=>'Пройгрышные споры пользователя',         En=>'Losing user disputes'}
B_choose_role           = {Ru=>'Выберите роль',                          En=>'Choose role'}
B_currency_types        = {Ru=>'Выберите валюту сделки',                 En=>'Choose currency type'}
B_push_amount_currency  = {Ru=>'Введите сумму сделки в',                 En=>'Enter the transaction amount in'}
B_push_conditions       = {Ru=>'Введите условия сделки',                 En=>'Enter deal conditions'}
B_invalid_amount        = {Ru=>'Не валидное число',                      En=>'Invalid amount'}
B_reject_deal_self      = {Ru=>'Вы отменили сделку',                     En=>'You canceled the deal'}
# TB_pending_pay_from_custumer= {Ru=>'Ожидание оплаты покупателем',            En=>'Pending pay by custumer'}

# # текст кнопок 
T_cancel     = {Ru=>'Отмена',                En=>'Cancel'}
T_select_contact = {Ru=>'Выбрать контакт',     En=>'Select contact'}
T_offer_deal = {Ru=>'Предложить сделку',     En=>'Offer a deal'}
T_comments   = {Ru=>'Отзывы',                En=>'Comments'}
T_disputes   = {Ru=>'Споры',                 En=>'Disputes'}
T_back       = {Ru=>'Назад',                 En=>'Back'}
T_wons       = {Ru=>'Выйграл споров',        En=>'Won disputs'}
T_losts      = {Ru=>'Проиграл споров',       En=>'Lost disputs'}
T_custumer   = {Ru=>'Я покупатель',          En=>'I`m custumer'}
T_seller     = {Ru=>'Я продавец',            En=>'I`m seller'}
T_cryptos    = {Ru=>'Криптовалюта',          En=>'Crypto-Currencies'}
T_another    = {Ru=>'Другое',                En=>'Another'}
T_confirm    = {Ru=>'Подтвердить',           En=>'Confirm'}
T_accept     = {Ru=>'Принять',               En=>'Accept'}
T_reject     = {Ru=>'Отклонить',             En=>'Reject'}
# Pay        = {Ru=>'Оплатить',              En=>'Pay'}

# # reply_markups
RM_start = -> {RM.call([T_find_user[$lang], T_deals[$lang], [T_profile[$lang], T_help[$lang]]])}
RM_cancel_to_start         = ->{ RM.call( [
  [{text:T_select_contact[$lang], request_user:{request_id:111}}],
   T_cancel[$lang]   
])}

# # inline buttons
# :language
IB_rus                    =    IB.call( Ru,                        "#{Ru}/Выбранный язык")
IB_en                     =    IB.call( En,                        "#{En}/Выбранный язык")
# :await_userTo_data
# UserToActions
IB_offer_deal             = -> {IB.call( T_offer_deal[$lang],      "Offer_deal/#{            $userTo.id}")}
IB_comments               = -> {IB.call( T_comments[$lang],        "Comments/#{              $userTo.id}")}
IB_disputes               = -> {IB.call( T_disputes[$lang],        "Disputs/#{               $userTo.id}")}
# TypeOfDisputs Comments Role CurrenyTypes
IB_back_to_userTo_actions = -> {IB.call( T_back[$lang],            "Back_to userTo_actions/#{$userTo.id}")}
# TypeOfDisputsB_await_username_or_id
IB_won_disputs             = ->{IB.call("#{T_wons[$lang]} (111)",  "Won_disputs/#{           $userTo.id}")}
IB_lost_disputs            = ->{IB.call("#{T_losts[$lang]} (111)", "Lost_disputs/#{          $userTo.id}")}
# WonDisputs LostDisputs
IB_back_to_type_of_disputs = ->{IB.call( T_back[$lang],            "Back_to TypeOfDisputs/#{ $userTo.id}")}
# Role
IB_custumer               = ->{IB.call(T_custumer[$lang],          "I`m custumer/#{          $userTo.id}")}
IB_seller                 = ->{IB.call(T_seller[$lang],            "I`m seller/#{            $userTo.id}")}
# CurrencyTypes
IB_crypto_currencies      = ->{IB.call(T_cryptos[$lang],           "Criptocurrencies/#{      $userTo.id}")}
IB_another                = ->{IB.call(T_another[$lang],           "Another/#{               $userTo.id}")}
# Currencies
IB_Arr_cryptocurrecues    = ->{ Arr_cryptoCurrecues.map {|crypto| IB.call(crypto, "Currency/#{crypto}/#{$userTo.id}")}}
IB_back_to_CurrencyTypes  = ->{ IB.call(T_back[$lang],             "back_to CurrencyTypes/#{ $userTo.id}")}   
# :confirmation_new_deal
IB_cofirm_new_deal        = ->{IB.call(T_confirm[$lang],           "Confirming_new_deal/#{   $userTo.id}")}   
IB_cancel_new_deal        = ->{IB.call(T_cancel[$lang],            "Cancel_new_deal/#{       $userTo.id}")}

# from_all_states
IB_accept                 = ->{IB.call(T_accept[$lang],            "Accept/#{$deal.id}")}
IB_reject                 = ->{IB.call(T_reject[$lang],            "Reject/#{$deal.id}")}

# I_pay             = ->(deal){Inline_B.new(text:Pay[$lang],              callback_data:"response_custumer to request_by_seller/pay/#{deal.id}")}
# I_cancel          = ->(deal){Inline_B.new(text:Cancel[$lang],           callback_data:"response_custumer to request_by_seller/cancel deal/#{deal.id}")}

# # inline markups
IM_languages               =     IM.call([[IB_rus, IB_en]])
IM_offer_deal              = ->{ IM.call([ IB_offer_deal.call, IB_comments.call, IB_disputes.call])}
IM_back_to_userTo_actions  = ->{ IM.call(  IB_back_to_userTo_actions.call)}
IM_type_of_disputs         = ->{ IM.call([ IB_won_disputs.call, IB_lost_disputs.call, IB_back_to_userTo_actions.call])}
IM_back_to_type_of_disputs = ->{ IM.call(  IB_back_to_type_of_disputs.call)}
IM_role                    = ->{ IM.call([ IB_custumer.call, IB_seller.call, IB_back_to_userTo_actions.call])}
IM_currency_types          = ->{ IM.call( [IB_crypto_currencies.call, IB_another.call, IB_back_to_userTo_actions.call])}
IM_cryptocurrencies        = ->{ IM.call(  IB_Arr_cryptocurrecues.call << IB_back_to_CurrencyTypes.call)}
IM_confirm_deal            = ->{ IM.call([ IB_cofirm_new_deal.call, IB_cancel_new_deal.call])}
IM_accept_reject           = ->{ IM.call([ IB_accept.call, IB_reject.call])}
# # M_pay_cancel      = ->(deal){Inline_M.new(inline_keyboard:[ I_pay.call(deal), I_cancel.call(deal)])}

# M_accept_reject_by_custumer=->(deal){Inline_M.new(inline_keyboard:[ I_pay.call(deal), I_cancel.call(deal)])}
# M_accept_reject_by_seller  =->(deal){Inline_M.new(inline_keyboard:[ I_accept.call(deal), I_reject.call(deal)])}
# 
B_user               = {Ru=>"👤Пользователь:",          En=>"👤User:"}
B_first_name         = {Ru=>"Имя:",                     En=>"First name:"}
B_last_name          = {Ru=>"Фамилия:",                 En=>"Last name:"}
B_username           = {Ru=>"username:",                En=>"username:"}
B_user_id            = {Ru=>"id:",                      En=>"id:"}
B_deals_how_seller   = {Ru=>"📈Сделок как продавец:",   En=>"📈Deals how seller:"}
B_deals_how_custumer = {Ru=>"📉Сделок как покупатель:", En=>"📉Deals how custumer:"}
B_dusputs            = {Ru=>"⚖️Споры:",                  En=>"⚖️Dusputs:"}
B_comments           = {Ru=>"📬Отзывы:",                En=>"📬Comments:"}
B_rating             = {Ru=>"⭐️Рейтинг:",               En=>"⭐️Rating:"}
B_deal_with          = {Ru=>"Сделка с ",                En=>"Deal with "}
B_conditions         = {Ru=>"Условия сделки:",          En=>"Conditions:"}
B_amount_deal        = {Ru=>"Cумма сделки:",            En=>"Amount:"}
B_comission          = {Ru=>"Комиссия гаранта:",        En=>"Comission:"}
B_amount_result      = {Ru=>"Сумма к оплате:",          En=>"Result amount:"}
B_offer              = {Ru=>"Предложение",              En=>"Offer"}
B_from               = {Ru=>"от",                       En=>"from"}
B_to_buy             = {Ru=>"покупки",                  En=>"to buy"}
B_to_sell            = {Ru=>"продажи",                  En=>"to sell"}
B_deal_id            = {Ru=>"Сделка №",                 En=>"Deal №"}
B_reject_deal        = {Ru=>"Отклонил сделку",          En=>"Reject deal"}
B_custumer           = {Ru=>"Покупатель",               En=>"Custumer"}
B_seller             = {Ru=>"Продавец",                 En=>"Seller"}
B_accessed           = {Ru=>"принял сделку №",          En=>"accessed deal №"}
B_accessed_by_seller = {
  Ru=>"Принял сделку, чтобы продолжить, передайте средства на храниние гаранту",          
  En=>"Accepted the deal, to continue, transfer the funds for safekeeping to the guarant"
}
###########################################
B_userTo_sub_info = ->(user = $userTo){
  text = ""
  text << "<b>#{B_first_name[$lang]}</b> #{user.first_name } \n" if user.first_name != '-'
  text << "<b>#{B_last_name[$lang] }</b> #{user.last_name  } \n" if user.last_name  != '-'
  text << "<b>#{B_username[$lang]  }</b> #{user.username   } \n" if user.username   != '-'
  text << "<b>#{B_user_id[$lang]   }</b> #{user.telegram_id}\n"
}
B_deal_data = ->{%{
<b>#{B_conditions[$lang]}</b>
#{$user.conditions}
#{B_amount_deal[$lang]  } <b>#{$user.amount} #{$user.currency}</b>
#{B_comission[$lang]    } <b>999</b>
#{B_amount_result[$lang]} <b>999</b>
}}
###########################################
B_userTo_info = ->{%{
<b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call}
<b>#{B_deals_how_seller[$lang]}</b>
<b>#{B_deals_how_custumer[$lang]}</b>
<b>#{B_dusputs[$lang]}</b>
<b>#{B_comments[$lang]}</b>

<b>#{B_rating[$lang]}</b> 5/5
}}

B_confirm_deal = ->{%{
#{B_deal_with[$lang]} <b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call}
#{B_deal_data.call}
}}

B_request_deal_self = ->{
  return "Запрос на сделкy № <b>#{$deal.id}</b> успешно отправлен, ожидвайте подтверждения"      if $lang == Ru
  return "Request to deal № <b>#{ $deal.id}</b> sent successfully, please wait for confirmation" if $lang == En
}

B_request_deal_to_userTo = ->(action){%{
#{B_offer[$lang]} #{action} #{B_from[$lang]}
#{B_userTo_sub_info.call($user)}
#{B_deal_data.call}
}}

B_reject_deal_userTo = ->{%{
#{B_deal_id[$lang]} #{$deal.id}
<b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call($user)} 
#{B_reject_deal[$lang]}
}}

B_request_deal_to_custumer = ->{%{
#{B_seller[$lang]}
#{B_userTo_sub_info.call($user)}
#{B_accessed_by_seller[$lang]}
}}

B_success_notify = {
  Ru=>"Принял сделку, средства заморожены на счету гаранта, вы можете передать товар/оказать услугу.\nЗавершить сделку может покупатель. Если у вас возник спор, то вы можете вызвать модератора, перейдя в раздел 'Сделки'.",
  En=>"I accepted the deal, the funds are frozen on the account of the guarantor, you can transfer the goods / provide the service.\nThe buyer can complete the transaction. If you have a dispute, you can call a moderator by going to the 'Deals' section."
}

B_notifi_to_seller_success_payed = ->{%{
#{B_deal_id[$lang]} #{$deal.id}
#{B_custumer[$lang]}
#{B_userTo_sub_info.call($user)}
#{B_success_notify[$lang]}
}}

B_notify_to_custumer_success_payed = {
  Ru=>'Средства переведены на хранение гаранту', 
  En=>'The funds were transferred to the safekeeping of the guarant'
}