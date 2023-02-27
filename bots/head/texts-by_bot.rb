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
B_deal_id            = {Ru=>"Сделка ",                  En=>"Deal "}
B_reject_deal        = {Ru=>"Отклонил сделку",          En=>"Reject deal"}
B_custumer           = {Ru=>"Покупатель",               En=>"Custumer"}
B_seller             = {Ru=>"Продавец",                 En=>"Seller"}
B_accessed           = {Ru=>"принял сделку №",          En=>"accessed deal №"}
B_accessed_by_seller = {
  Ru=>"Принял сделку, чтобы продолжить, передайте средства на храниние гаранту",          
  En=>"Accepted the deal, to continue, transfer the funds for safekeeping to the guarant"
}
B_opened_by          = {Ru=>"Спор открыт",              En=>"Dispute opened by"} 
B_by_seller          = {Ru=>"Продавцом",                En=>"Seller"} 
B_by_custumer        = {Ru=>"Покупателем",              En=>"Custumer"} 
###########################################
B_userTo_sub_info = ->(user = $userTo){
  text = ""
  text << "<b>#{B_first_name[$lg]}</b> #{user.first_name } \n" if user.first_name != '-'
  text << "<b>#{B_last_name[$lg] }</b> #{user.last_name  } \n" if user.last_name  != '-'
  text << "<b>#{B_username[$lg]  }</b> @#{user.username   } \n" if user.username   != '-'
  text << "<b>#{B_user_id[$lg]   }</b> #{user.telegram_id}\n"
}

B_deal_hash = ->(model = $user){
"<b>#{B_deal_id[$lg]}</b> ##{model.hash_name}"}

B_deal_data = ->(model = $user){
%{<b>#{B_conditions[$lg]}</b>
#{model.conditions}
#{B_amount_deal[$lg]  } <b>#{model.amount} #{model.currency}</b>
#{B_comission[$lg]    } <b>999</b>
#{B_amount_result[$lg]} <b>999</b>}}
###########################################
B_userTo_info = ->{
%{<b>#{B_user[$lg]}</b>
#{B_userTo_sub_info.call}
<b>#{B_deals_how_seller[$lg]}</b>
<b>#{B_deals_how_custumer[$lg]}</b>
<b>#{B_dusputs[$lg]}</b>
<b>#{B_comments[$lg]}</b>

<b>#{B_rating[$lg]}</b> 5/5}}

B_confirm_deal = ->{
%{#{B_deal_with[$lg]} <b>#{B_user[$lg]}</b>
#{B_userTo_sub_info.call}
#{B_deal_data.call}}}

B_request_deal_self = ->{
  return "Запрос на сделкy ##{$deal.hash_name} успешно отправлен, ожидайте подтверждения"       if $lg == Ru
  return "Request to deal ##{ $deal.hash_name} sent successfully, please wait for confirmation" if $lg == En
}

B_request_deal_to_userTo = ->(action){
%{#{B_offer[$lg]} #{action} #{B_from[$lg]}
#{B_userTo_sub_info.call($user)}
#{B_deal_hash.call}
#{B_deal_data.call}}}

B_reject_deal_userTo = ->{
%{#{B_deal_id[$lg]} ##{$deal.hash_name}
<b>#{B_user[$lg]}</b>
#{B_userTo_sub_info.call($user)} 
#{B_reject_deal[$lg]}}}

B_request_deal_to_custumer = ->{
%{#{B_seller[$lg]}
#{B_userTo_sub_info.call($user)}
#{B_accessed_by_seller[$lg]}}}

B_success_notify = {
  Ru=>"Принял сделку, средства заморожены на счету гаранта, вы можете передать товар/оказать услугу.\nЗавершить сделку может покупатель. Если у вас возник спор, то вы можете вызвать модератора, перейдя в раздел 'Сделки'.",
  En=>"I accepted the deal, the funds are frozen on the account of the guarantor, you can transfer the goods / provide the service.\nThe buyer can complete the transaction. If you have a dispute, you can call a moderator by going to the 'Deals' section."
}

B_notifi_to_seller_success_payed = ->{
%{#{B_deal_id[$lg]} ##{$deal.hash_name}
#{B_custumer[$lg]}
#{B_userTo_sub_info.call($user)}
#{B_success_notify[$lg]}}}

B_notify_to_custumer_success_payed = {
  Ru=>'Средства переведены на хранение гаранту', 
  En=>'The funds were transferred to the safekeeping of the guarant'
}

# 🤝Сделки🤝'

B_none_deals_active = {Ru=>'У вас нет активных сделок', En=>'You don`t have any active deals'}
B_deal_full_info = ->(deal) {
%{#{B_deal_with[$lg]} <b>#{B_user[$lg]}</b>
#{B_userTo_sub_info.call}
#{B_deal_hash.call}
#{B_deal_data.call(deal)}}}


B_disput_offer = -> (seller, custumer, deal, dispute, initiator, lg){
  text = "<b>Продавец</b>\n"
  text << "<b>#{B_first_name[lg]}</b> #{seller.first_name } \n" if seller.first_name != '-'
  text << "<b>#{B_last_name[lg] }</b> #{seller.last_name  } \n" if seller.last_name  != '-'
  text << "<b>#{B_username[lg]  }</b> @#{seller.username  } \n" if seller.username   != '-'
  text << "<b>#{B_user_id[lg]   }</b> #{seller.telegram_id}\n"
  text << "\n"
  text << "<b>Покупатель</b>\n"
  text << "<b>#{B_first_name[lg]}</b> #{custumer.first_name } \n" if custumer.first_name != '-'
  text << "<b>#{B_last_name[lg] }</b> #{custumer.last_name  } \n" if custumer.last_name  != '-'
  text << "<b>#{B_username[lg]  }</b> @#{custumer.username  } \n" if custumer.username   != '-'
  text << "<b>#{B_user_id[lg]   }</b> #{custumer.telegram_id}\n"  
  text << "\n"
  text << "<b>#{B_deal_id[lg]}</b> ##{deal.hash_name}\n"
  text << "<b>#{B_conditions[lg]}</b>\n"
  text << "#{deal.conditions}\n"
  text << "<b>#{B_amount_deal[lg]}</b> #{deal.amount}\n"
  text << "<b>#{B_comission[lg]}</b> 999\n"
  text << "<b>#{B_amount_result[lg]}</b> 999\n"
  text << "\n"
  text << "#{B_opened_by[lg]} <b>#{initiator}</b>\n"
  text << "#{dispute.content}"
  text 
}
B_dispute_comment = -> (dispute){
  desision = dispute.dispute_lost
  text = "\n"
  case desision
  when 'seller_lost'
    text += "выйграл Покупатель"
  when 'custumer_lost'
    text += "выйграл Продавец"
  when 'all_lost'
    text += "проиграли и Покупатель и Продавец из-за нарушения"
  end
    text += "\n комментарий модератора @#{dispute.moderator.username} :\n #{dispute.comment_by_moderator}"
}

# 👨‍💼Профиль👨‍💼
B_empty_wallet = {Ru=>'Кошелёк пуст',    En=>'Wallet is empty'}
B_wallet       = {Ru=>'У вас в кошельке',En=>'In your wallet'}
B_view_wallet = {
wallet_content = B_wallet[$lg] + "\n\n"
$user.wallet.each do |obj|
  currency = obj.keys.first
  amount   = obj.values.first
  wallet_content += "#{currency} -- #{amount} \n"
end
wallet_content
}