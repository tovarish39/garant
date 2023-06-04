class StateMachine
    class_eval do
      include AASM
      aasm do
        state :confirmation_new_deal
  
        ## :confirmation_new_deal
        event :confirmation_new_deal_action, from: :confirmation_new_deal do
          transitions if: lambda {
                            data?(/Confirming_new_deal/)
                          }, after: :deal_request, to: :start # создание сделки и отправка на подтверждение seller || custumer
          transitions if: lambda {
                            data?(/Cancel_new_deal/)
                          }, after: :to_userTo_from_back, to: :userTo # "Отмена" сделки (не создание)
        end
      end
    end
  end
  


  def creating_deal(seller:, custumer:)
    deal = $user.deals.create(
      seller_id: seller.id,
      custumer_id: custumer.id,
      currency: $user.currency,
      amount: $user.amount,
      conditions: $user.conditions
      # hash_name:  $user.hash_name
    )
    deal.update(hash_name: get_hash_name(deal.id))
    deal
  end
  
  def send_request_to_userTo(action)
    send_message_to_user(
      B_request_deal_to_userTo.call(action),
      $userTo,
      IM_accept_reject.call
    )
  end
  
  #################################################################################
  # создание сделки и отправка на подтверждение seller || custumer
  def deal_request
    return unless get_userTo_from_new_deal # defining $userTo
  
    self_seller   = $user.role == 'I`m seller'
    self_custumer = $user.role == 'I`m custumer'
    # seller создал deal
    if    self_seller
      $deal = creating_deal(seller: $user, custumer: $userTo)
      send_request_to_userTo(B_to_sell[$lg])
    # custumer создал deal
    elsif self_custumer
      $deal = creating_deal(seller: $userTo, custumer: $user)
      send_request_to_userTo(B_to_buy[$lg])
    end
    send_message(B_request_deal_self.call) # уведомление создающему дело
    to_start
  end
  #######################################################################################
  
  def get_hash_name(id)
    drow_zeros_amount = 5 - id.to_s.size
    hash_name = id.to_s
    drow_zeros_amount.times { hash_name = "0#{hash_name}" }
    hash_name = "N#{hash_name}"
  end
  