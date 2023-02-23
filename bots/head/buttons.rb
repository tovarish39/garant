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

# # reply_markups
RM_start = -> {RM.call([T_find_user[$lang], T_deals[$lang], [T_profile[$lang], T_help[$lang]]])}
RM_cancel_to_start         = ->{ RM.call( [
  [{text:T_select_contact[$lang], request_user:{request_id:111}}],
   T_cancel[$lang]   
])}
# :deals_menu
RM_deals_menu =->{RM.call([T_active[$lang], T_deals_history[$lang], T_disputs[$lang], T_back[$lang]])}
RM_cancel     =->{RM.call([T_cancel[$lang]])}

# # inline buttons
# :language
IB_rus                    =    IB.call( Ru,                        "#{Ru}/Выбранный язык")
IB_en                     =    IB.call( En,                        "#{En}/Выбранный язык")
# :await_userTo_data
# UserToActions
IB_offer_deal             = -> {IB.call( T_offer_deal[$lang],      "Offer_deal/#{            $userTo.id}")}
IB_comments               = -> {IB.call( T_comments[$lang],        "Comments/#{              $userTo.id}")}
IB_disputes               = -> {IB.call( T_disputs[$lang],        "Disputs/#{               $userTo.id}")}
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

# 🤝Сделки🤝 
## :deals_active
IB_cancel_exist_deal = ->(deal){IB.call(T_cancel_deal[$lang],       "Cancel_exist_deal/#{deal.id}")}
IB_open_disput       = ->(deal){IB.call(T_open_disput[$lang],       "Open_disput/#{      deal.id}")}
IB_finish_deal       = ->(deal){IB.call(T_finish_deal[$lang],       "Finish_deal/#{      deal.id}")}

# from_all_states
IB_accept                 = ->{IB.call(T_accept[$lang],            "Accept/#{$deal.id}")}
IB_reject                 = ->{IB.call(T_reject[$lang],            "Reject/#{$deal.id}")}


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