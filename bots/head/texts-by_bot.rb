# # сообщения бота
B_choose_language       = "Выберите язык / Choose language"
B_choose_action         = {Ru=>'Выберите действие из меню',              En=>'Choose action in menu'}
B_await_username_or_id  = {
  Ru=>'Отправьте username или id пользователя или выберите из списка контактов, нажав на кнопку',
  En=>'Send username or user id or select from the contact list by clicking on the button'
}
B_userTo_not_found      = {Ru=>'Пользователь не найден',                 En=>'User not found'}
B_userTo_not_subscr     = {Ru=>"Пользователь не подписан на бота",       En=>"The user is not subscribed to the bot"}
B_userTo_comments       = {Ru=>'Отзывы о пользователе',                  En=>'Users comments'}
B_disputs_by_userTo     = {Ru=>'Споры пользователя',                     En=>'Users disputs'}
B_choose_role           = {Ru=>'Выберите роль',                          En=>'Choose role'}
B_currency_types        = {Ru=>'Выберите валюту сделки',                 En=>'Choose currency type'}
B_push_amount_currency  = {Ru=>'Введите сумму сделки в',                 En=>'Enter the transaction amount in'}
B_push_conditions       = {Ru=>'Введите условия сделки',                 En=>'Enter deal conditions'}
B_invalid_amount        = {Ru=>'Не валидное число',                      En=>'Invalid amount'}
B_reject_deal_self      = {Ru=>'Вы отменили сделку',                     En=>'You canceled the deal'}
B_info                  = {Ru=>'Информация о пользовтеле',               En=>'User information'}
B_couse_disput          = {Ru=>'Укажите причину спора',                  En=>'Specify the reason for the dispute'}
B_opened_disput         = {Ru=>'Открыт спор',                            En=>'Dispute opened'}
B_request               = {Ru=>'Запрос отправлен',                       En=>'Request has been sent'}

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
  text << "<b>#{B_username[$lang]  }</b> @#{user.username   } \n" if user.username   != '-'
  text << "<b>#{B_user_id[$lang]   }</b> #{user.telegram_id}\n"
}
B_deal_data = ->(model = $user){
%{<b>#{B_deal_id[$lang]}</b> ##{model.hash_name}
<b>#{B_conditions[$lang]}</b>
#{model.conditions}
#{B_amount_deal[$lang]  } <b>#{model.amount} #{model.currency}</b>
#{B_comission[$lang]    } <b>999</b>
#{B_amount_result[$lang]} <b>999</b>}}
###########################################
B_userTo_info = ->{
%{<b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call}
<b>#{B_deals_how_seller[$lang]}</b>
<b>#{B_deals_how_custumer[$lang]}</b>
<b>#{B_dusputs[$lang]}</b>
<b>#{B_comments[$lang]}</b>

<b>#{B_rating[$lang]}</b> 5/5}}

B_confirm_deal = ->{
%{#{B_deal_with[$lang]} <b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call}
#{B_deal_data.call}}}

B_request_deal_self = ->{
  return "Запрос на сделкy № <b>#{$deal.id}</b> успешно отправлен, ожидвайте подтверждения"      if $lang == Ru
  return "Request to deal № <b>#{ $deal.id}</b> sent successfully, please wait for confirmation" if $lang == En
}

B_request_deal_to_userTo = ->(action){
%{#{B_offer[$lang]} #{action} #{B_from[$lang]}
#{B_userTo_sub_info.call($user)}
#{B_deal_data.call}}}

B_reject_deal_userTo = ->{
%{#{B_deal_id[$lang]} #{$deal.id}
<b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call($user)} 
#{B_reject_deal[$lang]}}}

B_request_deal_to_custumer = ->{
%{#{B_seller[$lang]}
#{B_userTo_sub_info.call($user)}
#{B_accessed_by_seller[$lang]}}}

B_success_notify = {
  Ru=>"Принял сделку, средства заморожены на счету гаранта, вы можете передать товар/оказать услугу.\nЗавершить сделку может покупатель. Если у вас возник спор, то вы можете вызвать модератора, перейдя в раздел 'Сделки'.",
  En=>"I accepted the deal, the funds are frozen on the account of the guarantor, you can transfer the goods / provide the service.\nThe buyer can complete the transaction. If you have a dispute, you can call a moderator by going to the 'Deals' section."
}

B_notifi_to_seller_success_payed = ->{
%{#{B_deal_id[$lang]} #{$deal.id}
#{B_custumer[$lang]}
#{B_userTo_sub_info.call($user)}
#{B_success_notify[$lang]}}}

B_notify_to_custumer_success_payed = {
  Ru=>'Средства переведены на хранение гаранту', 
  En=>'The funds were transferred to the safekeeping of the guarant'
}

# 🤝Сделки🤝'

B_none_deals_active = {Ru=>'У вас нет активных сделок', En=>'You don`t have any active deals'}
B_deal_full_info = ->(deal) {
%{#{B_deal_with[$lang]} <b>#{B_user[$lang]}</b>
#{B_userTo_sub_info.call}
#{B_deal_data.call(deal)}}}