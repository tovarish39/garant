# frozen_string_literal: true

# главное меню
T_find_user        = { Ru => '🔎Найти пользователя🔎', En => '🔎Find_user🔎' }.freeze
T_deals            = { Ru => '🤝Сделки🤝',            En => '🤝Deals🤝' }.freeze
T_profile          = { Ru => '👨‍💼Профиль👨‍💼', En => '👨‍💼Profile👨‍💼' }.freeze
T_help             = { Ru => '😱Помощь😱', En => '😱Help😱' }.freeze

T_start_actions = [
  T_find_user[Ru], T_find_user[En],
  T_deals[Ru],     T_deals[En],
  T_profile[Ru],   T_profile[En],
  T_help[Ru],      T_help[En],
  '/start'
].freeze

Arr_cryptoCurrecues = %w[BTC ETH].freeze

# # текст кнопок
T_cancel         = { Ru => 'Отмена',                En => 'Cancel' }.freeze
T_select_contact = { Ru => 'Выбрать контакт',       En => 'Select contact' }.freeze
T_offer_deal     = { Ru => 'Предложить сделку',     En => 'Offer a deal' }.freeze
T_comments       = { Ru => 'Отзывы',                En => 'Comments' }.freeze
T_disputes       = { Ru => 'Споры',                 En => 'Disputes' }.freeze
T_back           = { Ru => 'Назад',                 En => 'Back' }.freeze
T_wons           = { Ru => 'Выйграл споров',        En => 'Won disputes' }.freeze
T_losts          = { Ru => 'Проиграл споров',       En => 'Lost disputes' }.freeze
T_custumer       = { Ru => 'Я покупатель',          En => 'I`m custumer' }.freeze
T_seller         = { Ru => 'Я продавец',            En => 'I`m seller' }.freeze
T_cryptos        = { Ru => 'Криптовалюта',          En => 'Crypto-Currencies' }.freeze
T_another        = { Ru => 'Другое',                En => 'Another' }.freeze
T_confirm        = { Ru => 'Подтвердить',           En => 'Confirm' }.freeze
T_accept         = { Ru => 'Принять',               En => 'Accept' }.freeze
T_reject         = { Ru => 'Отклонить',             En => 'Reject' }.freeze
T_active         = { Ru => 'Активные',              En => 'Active' }.freeze
T_requests       = { Ru => 'Запросы',               En => 'Requests' }.freeze
T_deals_history  = { Ru => 'История сделок',        En => 'Deals history' }.freeze
T_cancel_deal    = { Ru => 'Отменить сделку',       En => 'Cancel deal' }.freeze
T_open_disput    = { Ru => 'Открыть спор',          En => 'Open disput' }.freeze
T_finish_deal    = { Ru => 'Подтвердить',           En => 'Confirm' }.freeze
T_seller_lost    = { Ru => 'Продавец проиграл',     En => 'Seller lost' }.freeze
T_custumer_lost  = { Ru => 'Покупатель проиграл',   En => 'Custumer lost' }.freeze
T_all_lost       = { Ru => 'Нарушение',             En => 'Nonobservance' }.freeze
T_extract        = { Ru => 'Вывести',               En => 'Extract' }.freeze
T_star           = '⭐'
T_skip           = { Ru => 'Пропустить', En => 'Skip' }.freeze

# # reply_markupsnonobservance
RM_start = -> { RM.call([T_find_user[$lg], T_deals[$lg], [T_profile[$lg], T_help[$lg]]]) }
RM_cancel_to_start = lambda {
  RM.call([
            [{ text: T_select_contact[$lg], request_user: { request_id: 111 } }],
            T_cancel[$lg]
          ])
}
# :deals_menu
RM_deals_menu = -> { RM.call([T_active[$lg], T_requests[$lg], T_disputes[$lg], T_deals_history[$lg], T_back[$lg]]) }
RM_cancel = -> { RM.call([T_cancel[$lg]]) }

# # inline buttons
# :language
IB_rus                    =    IB.call(Ru,                        "#{Ru}/Выбранный язык")
IB_en                     =    IB.call(En,                        "#{En}/Выбранный язык")
# :await_userTo_data
# UserToActions
IB_offer_deal             = -> { IB.call(T_offer_deal[$lg],      "Offer_deal/#{$userTo.id}") }
IB_comments               = -> { IB.call(T_comments[$lg],        "Comments/#{$userTo.id}") }
IB_disputes               = -> { IB.call(T_disputes[$lg],        "Disputes/#{$userTo.id}") }
# TypeOfDisputes Comments Role CurrenyTypes
IB_back_to_userTo_actions = -> { IB.call(T_back[$lg],            "Back_to userTo_actions/#{$userTo.id}") }
# TypeOfDisputesB_await_username_or_id
IB_won_disputes             = -> { IB.call("#{T_wons[$lg]} (111)",  "Won_disputes/#{$userTo.id}") }
IB_lost_disputes            = -> { IB.call("#{T_losts[$lg]} (111)", "Lost_disputes/#{$userTo.id}") }
# WonDisputes LostDisputes
IB_back_to_type_of_disputes = -> { IB.call(T_back[$lg],            "Back_to TypeOfDisputes/#{$userTo.id}") }
# Role
IB_custumer               = -> { IB.call(T_custumer[$lg],          "I`m custumer/#{$userTo.id}") }
IB_seller                 = -> { IB.call(T_seller[$lg],            "I`m seller/#{$userTo.id}") }
# CurrencyTypes
IB_crypto_currencies      = -> { IB.call(T_cryptos[$lg],           "Criptocurrencies/#{$userTo.id}") }
IB_another                = -> { IB.call(T_another[$lg],           "Another/#{$userTo.id}") }
# Currencies
IB_Arr_cryptocurrecues    = lambda {
  Arr_cryptoCurrecues.map do |crypto|
    IB.call(crypto, "Currency/#{crypto}/#{$userTo.id}")
  end
}
IB_back_to_CurrencyTypes  = -> { IB.call(T_back[$lg], "back_to CurrencyTypes/#{$userTo.id}") }
# :confirmation_new_deal
IB_cofirm_new_deal        = -> { IB.call(T_confirm[$lg],           "Confirming_new_deal/#{$userTo.id}") }
IB_cancel_new_deal        = -> { IB.call(T_cancel[$lg],            "Cancel_new_deal/#{$userTo.id}") }

# 🤝Сделки🤝
## :deals_active
IB_cancel_exist_deal = -> { IB.call(T_cancel_deal[$lg],       "Cancel_exist_deal/#{$deal.id}") }
IB_open_disput       = -> { IB.call(T_open_disput[$lg],       "Open_disput/#{$deal.id}") }
IB_finish_deal       = -> { IB.call(T_finish_deal[$lg],       "Finish_deal/#{$deal.id}") }
IBs_stars            = lambda {
  line = []
  5.times do |i|
    i += 1
    line << IB.call("#{i}#{T_star}", "#{i}/stars/#{$deal.id}")
  end
  [line]
}
IB_add_comment = -> { IB.call(T_skip[$lg], 'skip_comment') }

# from_all_states
IB_accept                 = -> { IB.call(T_accept[$lg],            "Accept/#{$deal.id}") }
IB_reject                 = -> { IB.call(T_reject[$lg],            "Reject/#{$deal.id}") }

# mod-bot
IB_seller_lost   = ->(dispute, lg) { IB.call(T_seller_lost[lg],   "Decision/seller_lost/#{dispute.id}") }
IB_custumer_lost = ->(dispute, lg) { IB.call(T_custumer_lost[lg], "Decision/custumer_lost/#{dispute.id}") }
IB_all_lost      = ->(dispute, lg) { IB.call(T_all_lost[lg],      "Decision/all_lost/#{dispute.id}") }

# 👨‍💼Профиль👨‍💼
IB_extract       = -> { IB.call(T_extract[$lg], 'Extract') }

# # inline markups
IM_languages = IM.call([[IB_rus, IB_en]])
IM_offer_deal              = -> { IM.call([IB_offer_deal.call, IB_comments.call, IB_disputes.call]) }
IM_back_to_userTo_actions  = -> { IM.call(IB_back_to_userTo_actions.call) }
IM_type_of_disputes = lambda {
  IM.call([IB_won_disputes.call, IB_lost_disputes.call, IB_back_to_userTo_actions.call])
}
IM_back_to_type_of_disputes = -> { IM.call(IB_back_to_type_of_disputes.call) }
IM_role                    = -> { IM.call([IB_custumer.call, IB_seller.call, IB_back_to_userTo_actions.call]) }
IM_currency_types          = lambda {
  IM.call([IB_crypto_currencies.call, IB_another.call, IB_back_to_userTo_actions.call])
}
IM_cryptocurrencies        = -> { IM.call(IB_Arr_cryptocurrecues.call << IB_back_to_CurrencyTypes.call) }
IM_confirm_deal            = -> { IM.call([IB_cofirm_new_deal.call, IB_cancel_new_deal.call]) }
IM_accept_reject           = -> { IM.call([IB_accept.call, IB_reject.call]) }
# 🤝Сделки🤝
IM_seller_deal_actions     = -> { IM.call([IB_cancel_exist_deal.call, IB_open_disput.call]) }
IM_custumer_deal_actions   = -> { IM.call([IB_finish_deal.call, IB_open_disput.call]) }
IM_add_grade               = -> { IM.call(IBs_stars.call) }
IM_add_comment             = -> { IM.call([IB_add_comment.call]) }
# 👨‍💼Профиль👨‍💼
IM_extract                 = -> { IM.call(IB_extract.call) }

#########################################
# mod-bot
IM_dispute_offer    = ->(dispute, lg) { IM.call(IB.call(T_accept[lg], "Accept/#{dispute.id}")) }
IM_decision_actions = lambda { |dispute, lg|
  IM.call([
            IB_seller_lost.call(dispute, lg),
            IB_custumer_lost.call(dispute, lg),
            IB_all_lost.call(dispute, lg)
          ])
}
