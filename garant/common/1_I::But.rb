module I
  module But
    IB = -> (text, callback_data) {InlineKeyboardButton.new(text: text, callback_data: callback_data)}

    def self.ru;IB.call(
      Ru, 
      "#{Ru}/Выбранный язык");end

    def self.en;IB.call(
      En, 
      "#{En}/Выбранный язык");end

    def self.offer_deal;IB.call(
      T_offer_deal[$lg], 
      "Offer_deal/#{$userTo.id}");end

    def self.comments userTo_comments_size;IB.call(
      "#{T_comments[$lg]}(#{userTo_comments_size})",        
      "Comments/#{$userTo.id}");end
      
    def self.disputes userTo_disputes_size;IB.call(
      "#{T_disputes[$lg]}(#{userTo_disputes_size})",        
      "Disputes/#{$userTo.id}");end

    def self.back_to_userTo_actions;IB.call(
      T_back[$lg],
      "Back_to userTo_actions/#{$userTo.id}");end 
    
    def self.won_disputes(won_size);IB.call(
      "#{T_wons[$lg]} (#{won_size})",  
      "Won_disputes/#{$userTo.id}");end

    def self.lost_disputes(lost_size);IB.call(
      "#{T_losts[$lg]} (#{lost_size})", 
      "Lost_disputes/#{$userTo.id}");end
      
    def self.back_to_type_of_disputes;IB.call(
      T_back[$lg],            
      "Back_to TypeOfDisputes/#{$userTo.id}");end

    def self.custumer;IB.call(
      T_custumer[$lg],          
      "I`m custumer/#{$userTo.id}");end

    def self.seller;IB.call(
      T_seller[$lg],            
      "I`m seller/#{$userTo.id}");end

    def self.crypto_currencies;IB.call(
      T_cryptos[$lg],           
      "Criptocurrencies/#{$userTo.id}");end

    def self.another;IB.call(
      T_another[$lg],           
      "Another/#{$userTo.id}");end
  

    def self.back_to_CurrencyTypes;IB.call(
      T_back[$lg], 
      "back_to CurrencyTypes/#{$userTo.id}");end

    def self.cofirm_new_deal;IB.call(
      T_confirm[$lg],           
      "Confirming_new_deal/#{$userTo.id}");end

    def self.cancel_new_deal;IB.call(
      T_cancel[$lg],
      "Cancel_new_deal/#{$userTo.id}");end
  
    def self.cancel_exist_deal;IB.call(
      T_cancel_deal[$lg],       
      "Cancel_exist_deal/#{$deal.id}");end

    def self.open_disput;IB.call(
      T_open_disput[$lg],       
      "Open_disput/#{$deal.id}");end

    def self.finish_deal;IB.call(
      T_finish_deal[$lg],       
      "Finish_deal/#{$deal.id}");end
  
    def self.add_comment;IB.call(
      T_skip[$lg], 
      'skip_comment');end

    def self.accept;IB.call(
      T_accept[$lg],            
      "Accept/#{$deal.id}");end

    def self.reject;IB.call(
      T_reject[$lg],            
      "Reject/#{$deal.id}");end

    def self.seller_lost(dispute, lg);IB.call(
      T_seller_lost[lg],   
      "Decision/seller_lost/#{dispute.id}");end

    def self.custumer_lost(dispute, lg);IB.call(
      T_custumer_lost[lg], 
      "Decision/custumer_lost/#{dispute.id}");end

    def self.all_lost(dispute, lg);IB.call(
      T_all_lost[lg],      
      "Decision/all_lost/#{dispute.id}");end

    def self.extract;IB.call(
      T_extract[$lg], 
      'Extract');end

    def self.dispute_offer(dispute, lg);IB.call(
      T_accept[lg], 
      "Accept/#{dispute.id}");end


    def self.cryptocurrecues 
        T_cryptoCurrecues.map { |crypto| [IB.call(
            crypto, 
            "Currency/#{crypto}/#{$userTo.id}")]};end
    
    def self.stars            
      line = []
      5.times do |i|
        i += 1
        line << [IB.call("#{i}#{T_star}", "#{i}/stars/#{$deal.id}")]
      end
      line
    end

  end
end

    


    



    # IB_add_comment = -> { IB.call(T_skip[$lg], 'skip_comment') }
    # IB_accept                 = -> { IB.call(T_accept[$lg],            "Accept/#{$deal.id}") }
    # IB_reject                 = -> { IB.call(T_reject[$lg],            "Reject/#{$deal.id}") }
    
    # # mod-bot
    # IB_seller_lost   = ->(dispute, lg) { IB.call(T_seller_lost[lg],   "Decision/seller_lost/#{dispute.id}") }
    # IB_custumer_lost = ->(dispute, lg) { IB.call(T_custumer_lost[lg], "Decision/custumer_lost/#{dispute.id}") }
    # IB_all_lost      = ->(dispute, lg) { IB.call(T_all_lost[lg],      "Decision/all_lost/#{dispute.id}") }
    
    # 👨‍💼Профиль👨‍💼
    # IB_extract       = -> { IB.call(T_extract[$lg], 'Extract') }
    
    # from_all_states
    # IB_accept                 = -> { IB.call(T_accept[$lg],            "Accept/#{$deal.id}") }
    # IB_reject                 = -> { IB.call(T_reject[$lg],            "Reject/#{$deal.id}") }
    
    # mod-bot
    # IB_seller_lost   = ->(dispute, lg) { IB.call(T_seller_lost[lg],   "Decision/seller_lost/#{dispute.id}") }
    # IB_custumer_lost = ->(dispute, lg) { IB.call(T_custumer_lost[lg], "Decision/custumer_lost/#{dispute.id}") }
    # IB_all_lost      = ->(dispute, lg) { IB.call(T_all_lost[lg],      "Decision/all_lost/#{dispute.id}") }
    
    # 👨‍💼Профиль👨‍💼
    # IB_extract       = -> { IB.call(T_extract[$lg], 'Extract') }
      





    # UserToActions
    # IB_offer_deal             = ->                       { IB.call(T_offer_deal[$lg]                            ,       }
    # IB_comments               = -> (userTo_comments_size){ IB.call("#{T_comments[$lg]}(#{userTo_comments_size})",        "Comments/#{$userTo.id}") }
    # IB_disputes               = -> (userTo_disputes_size){ IB.call("#{T_disputes[$lg]}(#{userTo_disputes_size})",        "Disputes/#{$userTo.id}") }
    # TypeOfDisputes Comments Role CurrenyTypes
    # IB_back_to_userTo_actions = -> { IB.call(T_back[$lg],            "Back_to userTo_actions/#{$userTo.id}") }
    # TypeOfDisputesB_await_username_or_id
    # IB_won_disputes             = -> (won_size){ IB.call("#{T_wons[$lg]} (#{won_size})",  "Won_disputes/#{$userTo.id}") }
    # IB_lost_disputes            = -> (lost_size){ IB.call("#{T_losts[$lg]} (#{lost_size})", "Lost_disputes/#{$userTo.id}") }
    # # WonDisputes LostDisputes
    # IB_back_to_type_of_disputes = -> { IB.call(T_back[$lg],            "Back_to TypeOfDisputes/#{$userTo.id}") }
    # # Role
    # IB_custumer               = -> { IB.call(T_custumer[$lg],          "I`m custumer/#{$userTo.id}") }
    # IB_seller                 = -> { IB.call(T_seller[$lg],            "I`m seller/#{$userTo.id}") }
    # # CurrencyTypes
    # IB_crypto_currencies      = -> { IB.call(T_cryptos[$lg],           "Criptocurrencies/#{$userTo.id}") }
    # IB_another                = -> { IB.call(T_another[$lg],           "Another/#{$userTo.id}") }
    # Currencies  
    # IB_back_to_CurrencyTypes  = -> { IB.call(T_back[$lg], "back_to CurrencyTypes/#{$userTo.id}") }
    # # :confirmation_new_deal
    # IB_cofirm_new_deal        = -> { IB.call(T_confirm[$lg],           "Confirming_new_deal/#{$userTo.id}") }
    # IB_cancel_new_deal        = -> { IB.call(T_cancel[$lg],            "Cancel_new_deal/#{$userTo.id}") }
   # 🤝Сделки🤝
    ## :deals_active
    # IB_cancel_exist_deal = -> { IB.call(T_cancel_deal[$lg],       "Cancel_exist_deal/#{$deal.id}") }
    # IB_open_disput       = -> { IB.call(T_open_disput[$lg],       "Open_disput/#{$deal.id}") }
    # IB_finish_deal       = -> { IB.call(T_finish_deal[$lg],       "Finish_deal/#{$deal.id}") }