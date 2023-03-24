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
B_disputes_by_userTo     = {Ru=>'Споры пользователя',                     En=>'Users disputes'}
B_choose_role           = {Ru=>'Выберите роль',                          En=>'Choose role'}
B_currency_types        = {Ru=>'Выберите валюту сделки',                 En=>'Choose currency type'}
B_push_amount_currency  = {Ru=>'Введите сумму сделки в',                 En=>'Enter the transaction amount in'}
B_push_conditions       = {Ru=>'Введите условия сделки',                 En=>'Enter deal conditions'}
B_invalid_amount        = {Ru=>'Не валидное число',                      En=>'Invalid amount'}
B_reject_deal_self      = {Ru=>'Вы отменили сделку',                     En=>'You canceled the deal'}
B_info                  = {Ru=>'Информация о пользователе',               En=>'User information'}
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
B_with_seller        = {Ru=>" с 👤Продавцом:",          En=>" with 👤Seller:"}
B_with_custumer      = {Ru=>" с 👤Покупателем:",        En=>" with 👤Custumer:"}
B_conditions         = {Ru=>"Условия сделки:",          En=>"Conditions:"}
B_amount_deal        = {Ru=>"Cумма сделки:",            En=>"Amount:"}
B_comission          = {Ru=>"Комиссия гаранта:",        En=>"Comission:"}
B_amount_result      = {Ru=>"Сумма к оплате:",          En=>"Result amount:"}
B_offer              = {Ru=>"Предложение",              En=>"Offer"}
B_from               = {Ru=>"от",                       En=>"from"}
B_to_buy             = {Ru=>"покупки",                  En=>"to buy"}
B_to_sell            = {Ru=>"продажи",                  En=>"to sell"}
B_deal               = {Ru=>"Сделка ",                  En=>"Deal "}
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
B_pending_userTo     = {Ru=>"В ожидании подтверждения...", En=>"Pending confirmation..."}
B_leads              = {Ru=>"ведёт",                    En=>"leeds"}
B_canceled_by_seller = {
  Ru=>"Сделка была отменена Продавцом, средства возвращены Покупателю",
  En=>"The deal was canceled by the Seller, the funds were returned to the Custumer"
}
B_finished_by_custumer = {
  Ru=>"Сделка успешно завершена Покупателем, средства переведены Продавцу",
  En=>"The deal was successfully completed by the Custumer, the funds were transferred to the Seller"
}
B_finished_by_moderator = ->{
  return "Сделка завершена модератором @#{$moderators_username} \n комментарий \n #{$comment_by_moderator}" if $lg == Ru
  return "The deal was completed by the moderator @#{$moderators_username} \n комментарий \n #{$comment_by_moderator}" if $lg == En
}
B_rejected_by_seller   = {Ru=>"Отклонена Продавцом",   En=>'Rejected by seller'}
B_rejected_by_custumer = {Ru=>"Отклонена Покупателем", En=>'Rejected by custumer'}
B_funds_to_seller      = {Ru=>" Средства переведены на счёт Продавца",   En=>' Funds transferred to the Seller`s account'}
B_funds_to_custumer    = {Ru=>" Средства переведены на счёт Покупателя", En=>' Funds transferred to the Custumer`s account'}
B_funds_to_garant      = {Ru=>" Средства переведены на счёт Гаранта", En=>' Funds transferred to the Garant`s account'}
B_finished_by_admin    = {Ru=>"Завершена администратором", En=>'Finished by administrator'}
B_canceled_by_admin    = {Ru=>"Отменена администратором",  En=>'Canceled by administrator'}
B_by_admin_win_garant  = {Ru=>"Отменена администратором в пользу гаранта",  En=>'Canceled by the administrator in favor of the garant'}
###########################################
# ~~~~~~~~~~~~~~~~~~~~~~
B_user_info = ->(user){
  text = ""
  text << "<b>#{B_first_name[$lg]}</b> #{user.first_name } \n" if user.first_name != '-'
  text << "<b>#{B_last_name[$lg] }</b> #{user.last_name  } \n" if user.last_name  != '-'
  text << "<b>#{B_username[$lg]  }</b> @#{user.username  } \n" if user.username   != '-'
  text << "<b>#{B_user_id[$lg]   }</b> #{user.telegram_id} \n"
}
# ~~~~~~~~~~~~~~~~~~~~~~
B_deal_info = ->(deal){
%{<b>#{B_conditions[$lg]}</b>
#{deal.conditions}
#{B_amount_deal[$lg]  } <b>#{deal.amount} #{deal.currency}</b>
#{B_comission[$lg]    } <b>999</b>
#{B_amount_result[$lg]} <b>999</b>}}

B_deal_hash =->{"##{$deal.hash_name}"}

B_deal_status = ->{
# == nil 
# =~ /rejected/ 
# =~ /accessed/ 
# =~ /payed 
# =~ /dispute 
# == 'finished by_seller' 
# == 'finished by_custumer' 
# == 'finished by_moderator'   

# == 'finished by_administrator' 
# == 'canceled by_administrator',
# == 'garant win by_administrator'
  status   = $deal.status
  disputes = $deal.disputes
  if !disputes.empty?
    dispute       = disputes.first 
    # puts dispute.inspect
    # puts $deal.inspect
    initiator_id  = dispute.created_by_user_id
    is_in_process = dispute.status == 'in_process'
    created_by    = B_by_seller[$lg]   if $deal.seller_id.to_s   == initiator_id 
    created_by    = B_by_custumer[$lg] if $deal.custumer_id.to_s == initiator_id  
  end
  case 
  when status.nil?                       # "Запросы"
    B_pending_userTo[$lg]
  when status =~ /accessed/              # "Запросы"
    B_pending_userTo[$lg]
  when status =~ /payed/                 # 'Активные'
  when status =~ /dispute/               # "Споры"
    B_opened_by[$lg] + created_by + "#{(is_in_process ? "\n #{B_leads[$lg]} @#{dispute.moderator.username}" : '' )}"
  when status == 'canceled by_seller'    # "История сделок"
    B_canceled_by_seller[$lg]
  when status == 'finished by_custumer'  # "История сделок"
    B_finished_by_custumer[$lg]
  when status == 'finished by_moderator' # "История сделок"
    B_finished_by_moderator.call# + B_funds_to_custumer[$lg]
  when status == 'rejected by_seller' # "История сделок"
    B_rejected_by_seller[$lg]
  when status == 'rejected by_custumer' # "История сделок"
    B_rejected_by_custumer[$lg]
  when status == 'finished by_administrator' # "Завершена администратором"
    B_finished_by_admin[$lg] + "\n" + $comment_by_administrator + "\n" + B_funds_to_seller[$lg]
  when status == 'canceled by_administrator' # "Отменена администратором"
    B_canceled_by_admin[$lg] + "\n" + $comment_by_administrator + "\n" + B_funds_to_custumer[$lg]
  when status == 'garant win by_administrator' # "в пользу гаранта администратором"
    B_by_admin_win_garant[$lg] + "\n" + $comment_by_administrator + "\n" + B_funds_to_garant[$lg]
  end
}

    


B_deal_verbose =->(with, user = $userTo){%{
#{B_deal[$lg] + "#{("#" + $deal.hash_name) if !$deal.hash_name.nil? }" + "#{with == 'with_custumer' ? B_with_custumer[$lg] : B_with_seller[$lg]}"}
#{B_user_info.call(user)}
#{B_deal_info.call($deal)}
#{B_deal_status.call}
}}

B_deal_canceled_or_finished = ->{
%{#{B_deal[$lg]} ##{$deal.hash_name}

#{B_seller[$lg]}
#{B_user_info.call($seller)}

#{B_custumer[$lg]}
#{B_user_info.call($custumer)}

#{B_deal_info.call($deal)}
#{B_deal_status.call}
}}



###########################################
B_userTo_info = ->{
%{<b>#{B_user[$lg]}</b>
#{B_user_info.call($userTo)}
<b>#{B_deals_how_seller[$lg]}</b>
<b>#{B_deals_how_custumer[$lg]}</b>
<b>#{B_dusputs[$lg]}</b>
<b>#{B_comments[$lg]}</b>

<b>#{B_rating[$lg]}</b> 5/5}}

B_confirm_deal = ->(with){
%{#{B_deal[$lg] + (with == 'with_custumer' ? B_with_custumer[$lg] : B_with_seller[$lg])}
#{B_user_info.call($userTo)}
#{B_deal_info.call($user)}}}

B_request_deal_self = ->{
  return "Запрос на сделкy ##{$deal.hash_name} успешно отправлен, ожидайте подтверждения"       if $lg == Ru
  return "Request to deal ##{ $deal.hash_name} sent successfully, please wait for confirmation" if $lg == En
}

B_request_deal_to_userTo = ->(action){
%{#{B_offer[$lg]} #{action} #{B_from[$lg]}
#{B_user_info.call($user)}
#{B_deal_hash.call}
#{B_deal_info.call($deal)}}}

B_reject_deal_userTo = ->{
%{#{B_deal[$lg]} ##{$deal.hash_name}
<b>#{B_user[$lg]}</b>
#{B_user_info.call($user)} 
#{B_reject_deal[$lg]}}}

B_request_deal_to_custumer = ->{
%{#{B_seller[$lg]}
#{B_user_info.call($user)}
#{B_accessed_by_seller[$lg]}}}

B_success_notify = {
  Ru=>"Принял сделку, средства заморожены на счету гаранта, вы можете передать товар/оказать услугу.\nЗавершить сделку может покупатель. Если у вас возник спор, то вы можете вызвать модератора, перейдя в раздел 'Сделки'.",
  En=>"I accepted the deal, the funds are frozen on the account of the guarantor, you can transfer the goods / provide the service.\nThe buyer can complete the transaction. If you have a dispute, you can call a moderator by going to the 'Deals' section."
}

B_notifi_to_seller_success_payed = ->{
%{#{B_deal[$lg]} ##{$deal.hash_name}
#{B_custumer[$lg]}
#{B_user_info.call($user)}
#{B_success_notify[$lg]}}}

B_notify_to_custumer_success_payed = {
  Ru=>'Средства переведены на хранение гаранту', 
  En=>'The funds were transferred to the safekeeping of the guarant'
}

# 🤝Сделки🤝'
B_none_active_deals = {Ru=>'У вас нет активных сделок',           En=>'You don`t have any active deals'}
B_none_request_deals= {Ru=>'У вас нет запросов на сделки',       En=>'You don`t have any request deals'}
B_none_dispute_deals= {Ru=>'У вас нет сделки c открытым спором', En=>'You do not have a deal with an open dispute'}
B_none_history_deals= {Ru=>'У вас нет завершённых сделок',        En=>'You don`t have any history deals'}


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
  text << "<b>#{B_deal[lg]}</b> ##{deal.hash_name}\n"
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
    text += "выйграл Покупатель средства переведены Продавцу"
  when 'custumer_lost'
    text += "выйграл Продавец средства переведены Покупателю"
  when 'all_lost'
    text += "проиграли и Покупатель и Продавец из-за нарушения средства переходят в пользу Гаранту"
  end
    text += "\n комментарий модератора @#{dispute.moderator.username} :\n #{dispute.comment_by_moderator}"
}

# 👨‍💼Профиль👨‍💼
B_empty_wallet = {Ru=>'Кошелёк пуст',    En=>'Wallet is empty'}
B_wallet       = {Ru=>'У вас в кошельке',En=>'In your wallet'}

B_view_wallet = ->{
wallet_content = B_wallet[$lg] + "\n\n"
wallet =  $user.wallet
currencies = $user.wallet.keys
currencies.each do |currency|
  amount = wallet[currency]
  wallet_content << "#{currency} --- #{amount}\n"
end
wallet_content
}