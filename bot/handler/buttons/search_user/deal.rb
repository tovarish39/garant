# seva - 6016837864

# text нажата "Найти пользователя"
def find_userTo
  puts 'find_userTo'
  send_message(Send_username_or_id[$lang],Cancel_to_start_markup.call)
end

######################################################
def userTo_exist?
  user_by_telegram_id = try_by_telegram_id() 
  user_by_username    = try_by_username()

  to_user = user_by_telegram_id || user_by_username
  $user.update(to_user_id:to_user.id) if to_user
  to_user
end

def userTo_not_found
  send_message(User_not_found[$lang])
end

def run_to_userTo
  to_user = User.find($user.to_user_id)
  $user.update(
    # to_user_id:to_user.id,
    role:      nil,
    currency:  nil,
    amount:    nil,
    conditions:nil
  )

  send_message(To_user_info.call(to_user, $lang), Propose_deal_markup.call) if $mes.class == Message
  edit_message(To_user_info.call(to_user, $lang), Propose_deal_markup.call) if $mes.class == Callback
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

  deal = $user.deals.create(
    seller_user_id:   ($user.role == 'seller') ? $user.id :  to_user.id,
    custumer_user_id: ($user.role != 'seller') ? $user.id :  to_user.id,
    currency: $user.currency,
    amount: $user.amount,
    conditions:$user.conditions,
    state:"request_to : #{($user.role == 'seller') ? 'custumer' : 'seller'}"
  )

  send_message(Request_deal.call(deal, $lang)) # уведомление создающему дело
  send_message_to_user(Request_deal_to_user.call(deal, $user, $lang), to_user, M_Accept_reject.call(deal)) # запрос на дело 
  start()
end
######################################################################################
