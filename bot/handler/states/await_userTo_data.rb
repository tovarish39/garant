



def userTo_not_found
  send_message(B_userTo_not_found[$lang])  if text?()        # при вводе telegram_id || username
  send_message(B_userTo_not_subscr[$lang]) if user_shared?() # при выборе из списка контактов
end

def run_to_userTo
  userTo = User.find($user.userTo_id)
  $user.update(
    userTo_id: userTo.id,
    role:      nil,
    currency:  nil,
    amount:    nil,
    conditions:nil
  )

  send_message(B_userTo_info.call, IM_offer_deal.call)
end

def cancel
#   delete_pushed()
  to_start()
end

