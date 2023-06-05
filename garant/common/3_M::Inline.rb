module M
  module Inline
    IM = ->(inline_keyboard)  {InlineKeyboardMarkup.new(inline_keyboard: inline_keyboard) }
    
    def self.languages                = IM.call([
      [I::But.ru, I::But.en]      ])

    def self.back_to_userTo_actions   = IM.call([
      [I::But.back_to_userTo_actions]    ])

    def self.back_to_type_of_disputes = IM.call([
      [I::But.back_to_type_of_disputes]    ]) 

    def self.role                     = IM.call([
      [I::But.custumer], 
      [I::But.seller], 
      [I::But.back_to_userTo_actions]      ])

    def self.currency_types           = IM.call([
      [I::But.crypto_currencies], 
      [I::But.another], 
      [I::But.back_to_userTo_actions]    ])

    def self.cryptocurrencies         = IM.call(
      I::But.cryptocurrecues << [I::But.back_to_CurrencyTypes])

    def self.confirm_deal             = IM.call([
      [I::But.cofirm_new_deal], 
      [I::But.cancel_new_deal]     ])

    def self.accept_reject            = IM.call([
      [I::But.accept], 
      [I::But.reject]        ]) 

    def self.seller_deal_actions      = IM.call([
      [I::But.cancel_exist_deal], 
      [I::But.open_disput]         ])

    def self.custumer_deal_actions    = IM.call([
      [I::But.finish_deal], 
      [I::But.open_disput]       ])

    def self.add_grade                = IM.call(
      [I::But.stars]        )

    def self.add_comment              = IM.call([
      [I::But.add_comment]       ])

    def self.extract                  = IM.call([
      [I::But.extract]       ])

    def self.offer_deal(userTo_comments_size, userTo_disputes_size) ; IM.call([
      [I::But.offer_deal], 
      [I::But.comments(userTo_comments_size)], 
      [I::But.disputes(userTo_disputes_size)] ]) ;end

    def self.type_of_disputes(won_size, lost_size)                  ;IM.call([
      [I::But.won_disputes(won_size)], 
      [I::But.lost_disputes(lost_size)], 
      [I::But.back_to_userTo_actions]        ]) ;end  

    def self.dispute_offer(dispute, lg)                             ;IM.call([
      [I::But.dispute_offer(dispute, lg)]  ]);end  
    
    def self.decision_actions(dispute, lg)                          ;IM.call([
      [I::But.seller_lost(dispute, lg)],
      [I::But.custumer_lost(dispute, lg)],
      [I::But.all_lost(dispute, lg)]         ]);end


  end
end



  

  # IM_decision_actions = ->(dispute, lg) {  IM.call([
  #             IB_seller_lost.call(dispute, lg),
  #             IB_custumer_lost.call(dispute, lg),
  #             IB_all_lost.call(dispute, lg)
  #           ])
  # }


    # IM = ->(inline_keyboard)  {
  #   InlineKeyboardMarkup.new(
  #     inline_keyboard: inline_keyboard
  #     ) 
  #   }



  # IM_languages = IM.call([[IB_rus, IB_en]])
  # IM_offer_deal              = -> (userTo_comments_size, userTo_disputes_size){  }

    # IM_back_to_userTo_actions  = -> { IM.call(IB_back_to_userTo_actions.call) }
  # IM_type_of_disputes = ->(won_size, lost_size) {
    
  # }
  # IM_back_to_type_of_disputes = -> { IM.call(IB_back_to_type_of_disputes.call) }
  # IM_role                    = -> { IM.call([IB_custumer.call, IB_seller.call, IB_back_to_userTo_actions.call]) }
  # IM_currency_types          = -> {
  #   IM.call([IB_crypto_currencies.call, IB_another.call, IB_back_to_userTo_actions.call])
  # }

    # IM_cryptocurrencies        = -> { IM.call(IB_Arr_cryptocurrecues.call << IB_back_to_CurrencyTypes.call) }
  # IM_confirm_deal            = -> { IM.call([IB_cofirm_new_deal.call, IB_cancel_new_deal.call]) }
  # IM_accept_reject           = -> { IM.call([IB_accept.call, IB_reject.call]) }
  # # 🤝Сделки🤝
  # IM_seller_deal_actions     = -> { IM.call([IB_cancel_exist_deal.call, IB_open_disput.call]) }
  # IM_custumer_deal_actions   = -> { IM.call([IB_finish_deal.call, IB_open_disput.call]) }
  # IM_add_grade               = -> { IM.call(IBs_stars.call) }
  # IM_add_comment             = -> { IM.call([IB_add_comment.call]) }
  # 👨‍💼Профиль👨‍💼
  # IM_extract                 = -> { IM.call(IB_extract.call) }


  #########################################
  # mod-bot
  # IM_dispute_offer    = ->(dispute, lg) { IM.call(IB.call(T_accept[lg], "Accept/#{dispute.id}")) }