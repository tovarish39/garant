def searching_user
  User.find_by(telegram_id:$mes.from.id)
end

def create_user
  User.create(
    telegram_id: $mes.from.id,
    username: $mes.from.username || "-",
  )
end

def update_username_if_changed
  username_cur = $mes.from.username
  username_writen = $user.username
  $user.update(username: username_cur || '-') if username_cur != username_writen
end

def start
  $mes = ($mes.class == Callback) ? $mes.message : $mes
  $user.update(new_deal:'false')

  $bot.send_message(
    chat_id:$mes.chat.id,
    text:Start[$lang],
    reply_markup:Start_markup.call
  )
end

def language_choose()
  # handle_referer() if user_new_has_referer

  $mes = $mes.message if $mes.class == Callback
  $user.update(lang:nil)
  $bot.send_message(chat_id: $mes.chat.id, text: Choose_language, reply_markup:Languages_markup)
end

def language_selected
  $lang = $mes.data.split('/').first
  $user.update(lang:$lang)
  $bot.delete_message(chat_id:$mes.message.chat.id, message_id:$mes.message.message_id)
  start()
end