class StateMachine
    class_eval do
      include AASM
      aasm do
        state :await_disput_text
  
        event :await_disput_text_action, from: :await_disput_text do
          transitions if: -> { text_mes?(T_cancel[$lg]) }, after: :to_deals_menu, to: :deals_menu # "Отмена" создания спора
          transitions if: -> { text_mes? }, after: :create_dispute, to: :deals_menu # создание спора
        end
      end
    end
  end
  
  def from_redis dispute_id
    dispute = Dispute.find(dispute_id)
    # проверка модераторов по white list
    # avalible_morerator_telegram_ids = AvalibleModerator.all&.map(&:telegram_id)
  
    bot = Telegram::Bot::Client.new(Bot_Token_2_SECONDARY)
    $bot = bot.api
    Moderator.all.each do |moderator|
      $chat_id = moderator.telegram_id
      deal     = dispute.deal
      seller   = User.find(deal.seller_id)
      custumer = User.find(deal.custumer_id)
      lg = Ru # moderator.lang
      initiator = dispute.created_by_user_id == seller.id.to_s ? B_by_seller[lg] : B_by_custumer[lg]
      mes = send_message(
        B_disput_offer.call(seller, custumer, deal, dispute, initiator, lg),
        IM_dispute_offer.call(dispute, lg)
      )
      dispute.sended_to_moderators << { moderator.id => mes['result']['message_id'].to_s }
      dispute.save
    end
  end
  
  
  
  def create_dispute
      $deal = Deal.find($user.cur_deal_id)
      $deal.update(status: 'dispute request')
      dispute = $deal.disputes.create(
        created_by_user_id: $user.id,
        content: $mes.text.strip,
        status: 'pending_moderator'
      )
      self_role = $user.role
      with = 'with_custumer' if self_role == 'I`m seller'
      with = 'with_seller'   if self_role == 'I`m custumer'
      userTo_id = $deal.seller_id == $user.id ? $deal.custumer_id : $deal.seller_id
      $userTo = User.find(userTo_id)
      send_message_to_user("#{B_deal_verbose.call(with, $user)}\n\n#{B_opened_disput[$lg]}", $userTo)
      edit_message("#{B_deal_verbose.call(with)}\n\n#{B_opened_disput[$lg]}", nil, $user.mes_ids_to_edit[0])
      send_message(B_request[$lg], RM_deals_menu.call)
  
      from_redis(dispute.id)
    end
    