# seva - 6016837864

# text нажата "Найти пользователя"
def find_userTo
  send_message(B_await_username_or_id[$lang],IM_cancel_to_start.call)
end

######################################################
def userTo_exist?
  user_by_telegram_id = try_by_telegram_id() 
  user_by_username    = try_by_username()

  userTo = user_by_telegram_id || user_by_username
  $user.update(userTo_id:userTo.id) if userTo
  userTo
end

def userTo_not_found
  send_message(B_userTo_not_found[$lang])
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

  send_message(B_userTo_info.call(userTo), IM_offer_deal.call(userTo))
end

def cancel
  delete_pushed()
  to_start()
end

def try_by_telegram_id
  telegram_id = $mes.text.gsub(/\D/, '')
  found_user = User.find_by(telegram_id:telegram_id)
  if found_user
    return found_user if $user.telegram_id != found_user.telegram_id
  end
  nil
end

def try_by_username
  id = $mes.text =~ /^id/i
  unless id
    username = $mes.text.gsub(/[@, \s]/, '')
    found_user = User.find_by(username:username)
    if found_user 
      return found_user if $user.username != found_user.username  
    end
  end
  nil
end

def last_userTo # return userTo || false
  clicked_userTo_id = $mes.data.split('/').last
  last_userTo_id = $user.userTo_id
  return false if last_userTo_id != clicked_userTo_id
  userTo = User.find(last_userTo_id)
end

########################################################################
def choose_role
  $user.update(role:nil)
  edit_message(Choose_action[$lang], Actions_markup.call)
end


#######################################################################




def choose_type_of_currencies 
  role = $mes.data # если при выботе роли , а не "назад"
  $user.update(role:(role == 'Я покупатель') ? 'custumer' : 'seller') unless $mes.data == 'Назад к типам валют'

  edit_message(Choose_currencies_type[$lang], Currency_type_markup.call)
end
##########################################################################
def choose_specific_currency
  edit_message(Choose_currencies_type[$lang], Crypto_currencies_markup.call)
end

######################################################################
def choose_amount
  selected_currency = $mes.data.split('/').last
  # puts selected_currency
  $user.update(currency:selected_currency)

  send_message("#{Push_amount_currency[$lang]} <b>#{selected_currency}</b> " )
end
###################################
def choose_conditions  
    $user.update(amount:$mes.text)
    send_message(Push_conditions[$lang])
end

def amount_invalid
  send_message(Invalid_amount[$lang])
end

def confirming
  $user.update(conditions:$mes.text)
  $to_user = User.find($user.to_user_id)

  send_message(Confirm_deal.call($user, $to_user, $lang), Confirm_deal_markup.call)
end

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
######################################################################################
