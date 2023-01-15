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
  $bot.send_message(
    chat_id:$mes.chat.id,
    text:'приветствие',
    reply_markup:Start_markup.call
  )
end