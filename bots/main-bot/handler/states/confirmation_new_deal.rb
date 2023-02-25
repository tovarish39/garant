def creating_deal(seller:, custumer:) 
  deal = $user.deals.create(
    seller_id:   seller.id,
    custumer_id: custumer.id,
    currency:   $user.currency,
    amount:     $user.amount,
    conditions: $user.conditions,
    hash_name:  $user.hash_name
  )
end

def send_request_to_userTo(action)
  send_message_to_user(
    B_request_deal_to_userTo.call(action),
    $userTo,
    IM_accept_reject.call
    )
end
#################################################################################
# first request
def deal_request
  return if !get_userTo() # defining $userTo

  self_seller   = $user.role == 'I`m seller'
  self_custumer = $user.role == 'I`m custumer'
# seller создал deal
  if    self_seller
    $deal = creating_deal(seller:$user,   custumer:$userTo) 
    send_request_to_userTo(B_to_sell[$lang])
# custumer создал deal
  elsif self_custumer
    $deal = creating_deal(seller:$userTo, custumer:$user)
    send_request_to_userTo(B_to_buy[$lang])
  end
  send_message(B_request_deal_self.call) # уведомление создающему дело
  to_start()
end
#######################################################################################