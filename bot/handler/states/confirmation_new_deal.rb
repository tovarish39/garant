

def deal_request
  to_user = User.find($user.to_user_id)
  current_user_is_seller   = $user.role == 'seller'
  current_user_is_custumer = $user.role == 'custumer'

  deal = $user.deals.create(
    seller_user_id:   ( current_user_is_seller) ? $user.id :  to_user.id,
    custumer_user_id: (!current_user_is_seller) ? $user.id :  to_user.id,
    currency:           $user.currency,
    amount:             $user.amount,
    conditions:         $user.conditions,
    state:              "request_to #{(current_user_is_seller) ? 'custumer' : 'seller'}"
  )

  send_message(Request_deal.call(deal, $lang)) # уведомление создающему дело
  send_message_to_user(Request_deal_to_user.call(deal, $user, $lang), to_user, M_accept_reject_by_custumer.call(deal)) if current_user_is_seller   # запрос custumer, если сам seller
  send_message_to_user(Request_deal_to_user.call(deal, $user, $lang), to_user, M_accept_reject_by_seller.call(deal))   if current_user_is_custumer # запрос seller, если сам custumer
  start()
end