module InlineB
end

    IB = -> (text, callback_data) {Telegram::Bot::Types::InlineKeyboardButton.new(
            text: text, 
            callback_data: callback_data
            )}



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
    IB_Arr_cryptocurrecues    = -> {
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
    IB_accept                 = -> { IB.call(T_accept[$lg],            "Accept/#{$deal.id}") }
    IB_reject                 = -> { IB.call(T_reject[$lg],            "Reject/#{$deal.id}") }
    
    # mod-bot
    IB_seller_lost   = ->(dispute, lg) { IB.call(T_seller_lost[lg],   "Decision/seller_lost/#{dispute.id}") }
    IB_custumer_lost = ->(dispute, lg) { IB.call(T_custumer_lost[lg], "Decision/custumer_lost/#{dispute.id}") }
    IB_all_lost      = ->(dispute, lg) { IB.call(T_all_lost[lg],      "Decision/all_lost/#{dispute.id}") }
    
    # 👨‍💼Профиль👨‍💼
    IB_extract       = -> { IB.call(T_extract[$lg], 'Extract') }
    
    # # from_all_states
    # IB_accept                 = -> { IB.call(T_accept[$lg],            "Accept/#{$deal.id}") }
    # IB_reject                 = -> { IB.call(T_reject[$lg],            "Reject/#{$deal.id}") }
    
    # # mod-bot
    # IB_seller_lost   = ->(dispute, lg) { IB.call(T_seller_lost[lg],   "Decision/seller_lost/#{dispute.id}") }
    # IB_custumer_lost = ->(dispute, lg) { IB.call(T_custumer_lost[lg], "Decision/custumer_lost/#{dispute.id}") }
    # IB_all_lost      = ->(dispute, lg) { IB.call(T_all_lost[lg],      "Decision/all_lost/#{dispute.id}") }
    
    # # 👨‍💼Профиль👨‍💼
    # IB_extract       = -> { IB.call(T_extract[$lg], 'Extract') }
    