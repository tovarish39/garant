# text
def pending_user
  $user.update(pending:'user_to_deal', new_deal:{to_user_id:nil})
  $bot.send_message(chat_id:$mes.chat.id, text:Send_username_or_id[$lang], reply_markup:Cancel_to_start_markup.call)
end

#callback
def cancel
  $user.update(pending:nil)
  $mes = $mes.message if $mes.class == Callback
  $bot.delete_message(chat_id: $mes.chat.id, message_id:$mes.message_id)
  start() #text
end

# text callback
def search_user_for_deal earlier_finding_id = false
  $user.update(pending:nil)
  

  # $bot.delete_message(chat_id: $mes.chat.id, message_id:$mes.message_id - 1) if $mes.class == Message
  
  unless earlier_finding_id
    user_by_telegram_id = try_by_telegram_id() 
    user_by_username = try_by_username()

    $to_user = user_by_telegram_id || user_by_username
  else
    $to_user = User.find(earlier_finding_id)
    $mes = $mes.message
  end

  if $to_user
    $user.update(new_deal:{to_user_id:$to_user.id})
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
    $bot.send_message(chat_id:$mes.chat.id,text:text,reply_markup:Propose_deal_markup.call,parse_mode:'HTML')
  else
    $bot.send_message(chat_id:$mes.chat.id,text:User_not_found[$lang],reply_markup:Start_markup.call)
    start()
  end 
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

##################################################################


def earlier_user
  $to_user = User.find(get_to_user_id())
  $mes = $mes.message if $mes.class == Callback
  $bot.delete_message(chat_id: $mes.chat.id, message_id:$mes.message_id)
end

def new_deal
  earlier_user()
  $bot.send_message(chat_id: $mes.chat.id, text:Choose_action[$lang], reply_markup:Actions_markup.call)
end

def currency_types
  earlier_user()
  $bot.send_message(chat_id: $mes.chat.id, text:Choose_currencies_type[$lang], reply_markup:Currency_type_markup.call)
end

def crypto_currencies
  earlier_user()
  $bot.send_message(chat_id: $mes.chat.id, text:Choose_currencies_type[$lang], reply_markup:Crypto_currencies_markup.call)
end

def currency_to_amount
  selected_currency_to_deal = $mes.data.split('/')[1]
  earlier_user()
  $user.update(currency_to_deal:selected_currency_to_deal)

  $bot.send_message(chat_id: $mes.chat.id, text:"#{Push_amount_currency[$lang]} #{selected_currency_to_deal}", reply_markup:Push_amount_markup.call)
end

def try_write_amount_currency
  
end

#########################################################################


def comments
  $mes = $mes.message if $mes.class == Callback
  $bot.delete_message(chat_id: $mes.chat.id, message_id:$mes.message_id)

  texts = [Users_comments[$lang]]

  texts.each_with_index do |text, index|
    if index == texts.size - 1# последний текст 
      $bot.send_message( chat_id:$mes.chat.id,text:text, reply_markup:Back_to_user_markup.call)
    else
      $bot.send_message( chat_id:$mes.chat.id,text:text)
    end
  end
end

def finding_earlier_user
  $bot.delete_message(chat_id: $mes.message.chat.id, message_id:$mes.message.message_id)

  search_user_for_deal($to_user.id)
end

def disputs
  return if $to_user.id != $user.new_deal['to_user_id']
   
  


  unless $mes.data =~ /Назад к спорам/; $bot.delete_message(chat_id: $mes.message.chat.id, message_id:$mes.message.message_id);end

  $mes = $mes.message if $mes.class == Callback
  $bot.send_message(chat_id:$mes.chat.id, text:Disputs_by_user[$lang],reply_markup:Disputs_markup.call)
end

def disputes_list wins_losts
  $mes = $mes.message if $mes.class == Callback
  $bot.delete_message(chat_id: $mes.chat.id, message_id:$mes.message_id)
    

  texts = []
  texts << Won[$lang]  if wins_losts == 'wins'
  texts << Lost[$lang] if wins_losts == 'losts'


  texts.each_with_index do |text, index|
    if index == texts.size - 1# последний текст 
      $bot.send_message( chat_id:$mes.chat.id,text:text, reply_markup:Back_to_disputs_markup.call)
    else
      $bot.send_message( chat_id:$mes.chat.id,text:text)
    end
  end
end

def wins
  disputes_list('wins')
end

def losts
  disputes_list('losts')
end