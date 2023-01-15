def new_trans
  $user.update(new_trans:'true')
  $bot.send_message(chat_id:$mes.chat.id, text:Send_username_or_id[$lang])
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


def search_user_for_trans
  user_by_telegram_id = try_by_telegram_id() 
  user_by_username = try_by_username()

  user = user_by_telegram_id || user_by_username

  if user
    $bot.send_message(
      chat_id:$mes.chat.id,
      text:"#{User_data[$lang]} @#{user.username}/#{user.telegram_id}",
      reply_markup:Propose_dial_markup.call
    )
  else
    $bot.send_message(
      chat_id:$mes.chat.id,
      text:User_not_found[$lang]
    )
  end
  $user.update(new_trans:'false') 
end

def choose_role
  
end