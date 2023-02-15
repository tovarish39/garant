

######################################################
def userTo_exist?
  user_by_telegram_id = try_by_telegram_id() 
  user_by_username    = try_by_username()

  $userTo = user_by_telegram_id || user_by_username
  $user.update(userTo_id:$userTo.id) if $userTo
  $userTo
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

  send_message(B_userTo_info.call, IM_offer_deal.call)
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