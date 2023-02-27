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



# # текст кнопок 
T_cancel         = {Ru=>'Отмена',                En=>'Cancel'}
T_select_contact = {Ru=>'Выбрать контакт',       En=>'Select contact'}
T_offer_deal     = {Ru=>'Предложить сделку',     En=>'Offer a deal'}
T_comments       = {Ru=>'Отзывы',                En=>'Comments'}
T_disputs        = {Ru=>'Споры',                 En=>'Disputes'}
T_back           = {Ru=>'Назад',                 En=>'Back'}
T_wons           = {Ru=>'Выйграл споров',        En=>'Won disputs'}
T_losts          = {Ru=>'Проиграл споров',       En=>'Lost disputs'}
T_custumer       = {Ru=>'Я покупатель',          En=>'I`m custumer'}
T_seller         = {Ru=>'Я продавец',            En=>'I`m seller'}
T_cryptos        = {Ru=>'Криптовалюта',          En=>'Crypto-Currencies'}
T_another        = {Ru=>'Другое',                En=>'Another'}
T_confirm        = {Ru=>'Подтвердить',           En=>'Confirm'}
T_accept         = {Ru=>'Принять',               En=>'Accept'}
T_reject         = {Ru=>'Отклонить',             En=>'Reject'}
T_active         = {Ru=>'Активные',              En=>'Active'}
T_deals_history  = {Ru=>'История сделок',        En=>'Deals history'}
T_cancel_deal    = {Ru=>'Отменить сделку',       En=>'Cancel deal'}
T_open_disput    = {Ru=>'Открыть спор',          En=>'Open disput'}
T_finish_deal    = {Ru=>'Подтвердить',           En=>'Confirm'}
T_seller_lost    = {Ru=>'Продавец проиграл',     En=>'Seller lost'}
T_custumer_lost  = {Ru=>'Покупатель проиграл',   En=>'Custumer lost'}
T_all_lost       = {Ru=>'Нарушение',             En=>'Nonobservance'}
T_extract        = {Ru=>'Вывести',               En=>'Extract'}


# # reply_markupsnonobservance
RM_start = -> {RM.call([T_find_user[$lg], T_deals[$lg], [T_profile[$lg], T_help[$lg]]])}
RM_cancel_to_start         = ->{ RM.call( [
  [{text:T_select_contact[$lg], request_user:{request_id:111}}],
   T_cancel[$lg]   
])}
# :deals_menu
RM_deals_menu =->{RM.call([T_active[$lg], T_deals_history[$lg], T_disputs[$lg], T_back[$lg]])}
RM_cancel     =->{RM.call([T_cancel[$lg]])}

# # inline buttons
# :language
IB_rus                    =    IB.call( Ru,                        "#{Ru}/Выбранный язык")
IB_en                     =    IB.call( En,                        "#{En}/Выбранный язык")
# :await_userTo_data
# UserToActions
IB_offer_deal             = -> {IB.call( T_offer_deal[$lg],      "Offer_deal/#{            $userTo.id}")}
IB_comments               = -> {IB.call( T_comments[$lg],        "Comments/#{              $userTo.id}")}
IB_disputes               = -> {IB.call( T_disputs[$lg],        "Disputs/#{               $userTo.id}")}
# TypeOfDisputs Comments Role CurrenyTypes
IB_back_to_userTo_actions = -> {IB.call( T_back[$lg],            "Back_to userTo_actions/#{$userTo.id}")}
# TypeOfDisputsB_await_username_or_id
IB_won_disputs             = ->{IB.call("#{T_wons[$lg]} (111)",  "Won_disputs/#{           $userTo.id}")}
IB_lost_disputs            = ->{IB.call("#{T_losts[$lg]} (111)", "Lost_disputs/#{          $userTo.id}")}
# WonDisputs LostDisputs
IB_back_to_type_of_disputs = ->{IB.call( T_back[$lg],            "Back_to TypeOfDisputs/#{ $userTo.id}")}
# Role
IB_custumer               = ->{IB.call(T_custumer[$lg],          "I`m custumer/#{          $userTo.id}")}
IB_seller                 = ->{IB.call(T_seller[$lg],            "I`m seller/#{            $userTo.id}")}
# CurrencyTypes
IB_crypto_currencies      = ->{IB.call(T_cryptos[$lg],           "Criptocurrencies/#{      $userTo.id}")}
IB_another                = ->{IB.call(T_another[$lg],           "Another/#{               $userTo.id}")}
# Currencies
IB_Arr_cryptocurrecues    = ->{ Arr_cryptoCurrecues.map {|crypto| IB.call(crypto, "Currency/#{crypto}/#{$userTo.id}")}}
IB_back_to_CurrencyTypes  = ->{ IB.call(T_back[$lg],             "back_to CurrencyTypes/#{ $userTo.id}")}   
# :confirmation_new_deal
IB_cofirm_new_deal        = ->{IB.call(T_confirm[$lg],           "Confirming_new_deal/#{   $userTo.id}")}   
IB_cancel_new_deal        = ->{IB.call(T_cancel[$lg],            "Cancel_new_deal/#{       $userTo.id}")}

# 🤝Сделки🤝 
## :deals_active
IB_cancel_exist_deal = ->(deal){IB.call(T_cancel_deal[$lg],       "Cancel_exist_deal/#{deal.id}")}
IB_open_disput       = ->(deal){IB.call(T_open_disput[$lg],       "Open_disput/#{      deal.id}")}
IB_finish_deal       = ->(deal){IB.call(T_finish_deal[$lg],       "Finish_deal/#{      deal.id}")}

# from_all_states
IB_accept                 = ->{IB.call(T_accept[$lg],            "Accept/#{$deal.id}")}
IB_reject                 = ->{IB.call(T_reject[$lg],            "Reject/#{$deal.id}")}

# mod-bot
IB_seller_lost   = ->(dispute, lg){IB.call(T_seller_lost[lg],   "Decision/seller_lost/#{  dispute.id}")}
IB_custumer_lost = ->(dispute, lg){IB.call(T_custumer_lost[lg], "Decision/custumer_lost/#{dispute.id}")}
IB_all_lost      = ->(dispute, lg){IB.call(T_all_lost[lg],      "Decision/all_lost/#{dispute.id}")}

# 👨‍💼Профиль👨‍💼
IB_extract       = -> {IB.call(T_extract[$lg],  "Extract")}



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
# 🤝Сделки🤝 
IM_seller_deal_actions     = ->(deal){IM.call([IB_cancel_exist_deal.call(deal), IB_open_disput.call(deal)])}
IM_custumer_deal_actions   = ->(deal){IM.call([IB_finish_deal.call(deal), IB_open_disput.call(deal)])}
# 👨‍💼Профиль👨‍💼
IM_extract                 = ->(IM.call(IB.call(IB_extract.call)))



#########################################
# mod-bot
IM_dispute_offer    = -> (dispute, lg) {IM.call(IB.call(T_accept[lg], "Accept/#{dispute.id}"))}
IM_decision_actions = -> (dispute, lg) {IM.call([
  IB_seller_lost.call(dispute, lg),
  IB_custumer_lost.call(dispute, lg),
  IB_all_lost.call(dispute, lg)
])}