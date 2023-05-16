module InlineM
end

  IM = ->(inline_keyboard)  {
    Telegram::Bot::Types::InlineKeyboardMarkup.new(
      inline_keyboard: inline_keyboard
      ) 
    }



  IM_languages = IM.call([[IB_rus, IB_en]])
  IM_offer_deal              = -> (userTo_comments_size, userTo_disputes_size){ IM.call([IB_offer_deal.call, IB_comments.call(userTo_comments_size), IB_disputes.call(userTo_disputes_size)]) }
  IM_back_to_userTo_actions  = -> { IM.call(IB_back_to_userTo_actions.call) }
  IM_type_of_disputes = ->(won_size, lost_size) {
    IM.call([IB_won_disputes.call(won_size), IB_lost_disputes.call(lost_size), IB_back_to_userTo_actions.call])
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