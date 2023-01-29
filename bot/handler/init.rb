def view_languages()
  send_message(Choose_language, Languages_markup)
end

# callback
def language_selected
  $lang = $mes.data.split('/').first
  $user.update(lang:$lang)
  start()
end

def start
  User.update(
    to_user_id:nil,
    role:      nil,
    currency:  nil,
    amount:    nil,
    conditions:nil
  )
  send_message(Start[$lang], Start_markup.call)
end



def searching_user
  User.find_by(telegram_id:$mes.from.id)
end

def create_user
  User.create(
    telegram_id: $mes.from.id,
    username:    $mes.from.username || "-",
    first_name:  $mes.from.first_name || '-',
    last_name:   $mes.from.last_name || '-'
  )
end

def update_users_data_if_changed
  username_cur =       $mes.from.username
  username_writen =    $user.username

  first_name_cur =     $mes.from.first_name
  first_name_written = $mes.from.first_name

  last_name_cur =      $mes.from.last_name
  last_name_written =  $mes.from.last_name
 

  $user.update(username:   username_cur || '-')   if username_cur   != username_writen
  $user.update(first_name: first_name_cur || '-') if first_name_cur != first_name_written
  $user.update(last_name:  last_name_cur || '-')  if last_name_cur  != last_name_written
end






