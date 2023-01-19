def searching_user
  User.find_by(telegram_id:$mes.from.id)
end

def create_user
  User.create(
    telegram_id: $mes.from.id,
    username: $mes.from.username || "-",
    filling:Default_filling     
  )
end

def update_username_if_changed
  username_cur = $mes.from.username
  username_writen = $user.username
  $user.update(username: username_cur || '-') if username_cur != username_writen
end

def start
  $user.update(filling:Default_filling)
  send_message(Start[$lang], Start_markup.call)
end

def view_languages()
  $user.update(lang:'viewed')
  send_message(Choose_language, Languages_markup)
end

# callback
def language_selected
  $lang = $mes.data.split('/').first
  $user.update(lang:$lang)
  delete_pushed()
  start()
end
