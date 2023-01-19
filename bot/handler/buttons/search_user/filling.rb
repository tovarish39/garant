def new_deal
  edit_message(Choose_action[$lang], Actions_markup.call($next_mes_id))
end

def currency_types 
  $user.filling['role'] = $role_data
  $user.save

  edit_message(Choose_currencies_type[$lang], Currency_type_markup.call($next_mes_id))
end

def crypto_currencies
  edit_message(Choose_currencies_type[$lang], Crypto_currencies_markup.call($next_mes_id))
end

############################################################################################################################

# text
def pending_user
  $user.filling['pending'] ='to_user_id'
  $user.save
  
  send_message(Send_username_or_id[$lang],Cancel_to_start_markup.call($next_mes_id))
end

# callback
def cancel
  $user.filling['pending'] = 'nil'
  $user.save

  delete_pushed()
  # start() #text
end



# text callback
def search_user_for_deal
  if $mes.class == Message # text
    user_by_telegram_id = try_by_telegram_id() 
    user_by_username = try_by_username()

    $to_user = user_by_telegram_id || user_by_username
  elsif $mes.class == Callback # callback
    $to_user = User.find($user.filling['to_user_id'])
  end

  if $to_user
    $to_user_id = $to_user.id 
    $user.filling['to_user_id'] = $to_user_id      
    text = %{
<b>👤Пользователь:</b>
Имя Фамилия
<b>username:</b> #{$to_user.username}
<b>id</b> #{$to_user.telegram_id}

📈Сделок как покупатель: 0
📉Сделок как продавец: 0
⚖️Споры: 0
📬Отзывы: 0

⭐️Рейтинг: 5/5
    }
    send_message(text, Propose_deal_markup.call($next_mes_id)) if $mes.class == Message
    edit_message(text, Propose_deal_markup.call($next_mes_id)) if $mes.class == Callback
  else
    send_message(User_not_found[$lang])
    start()
  end
  $user.filling['pending']    = 'nil'
  $user.filling['role']       = 'nil'
  $user.filling['currency']   = 'nil'
  $user.filling['amount']     = 'nil'
  $user.filling['conditions'] = 'nil'
  $user.save  
  
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

def currency_to_amount
  $user.filling['currency'] = $currency_data
  $user.filling['pending'] = 'pending amount'
  $user.save

  delete_pushed()
  send_message("#{Push_amount_currency[$lang]} <b>#{$currency_data}</b> " )
end

def handle_amount
  valid_amount = /^\s*[\d]+([,\.][\d]+)?\s*$/ # из интернета, не вникал . только цифри и одна точка или запятая
  
  if $mes.text =~ valid_amount
    $user.filling['amount'] = $mes.text
    $user.filling['pending'] = 'pending conditions';
    $user.save

    send_message(Push_conditions[$lang])
  else
    send_message(Invalid_amount[$lang])
  end
end


def handle_condition
  $user.filling['conditions'] = $mes.text
  $user.filling['pending'] = 'stop-text';
  $user.save
  
  $to_user = User.find($user.filling['to_user_id'])

  send_message(Confirm_deal.call($user, $to_user, $lang), Confirm_deal_markup.call($next_mes_id))
end

def create_deal
  user_id_request = User.find($user.filling['to_user_id']).id

  $deal_created = $user.deals.create(
    seller_user_id:($user.filling['role'] == 'Seller') ? $user.id        :  user_id_request,
    order_user_id: ($user.filling['role'] == 'Seller') ? user_id_request :  $user.id
  )

  send_message(Request_deal.call($deal_created, $lang))
  start()
end