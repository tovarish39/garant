def searching_user model_name = 'User'
  model = model_name == 'User' ? User : Moderator
  model.find_by(telegram_id:$mes.from.id)
end

def create_user model_name = 'User' # создание User || Moderator
  model = model_name == 'User' ? User : Moderator
  model.wallet.create if model_name == 'User' 
  model.create(
      telegram_id: $mes.from.id,
      username:    $mes.from.username   || '-',
      first_name:  $mes.from.first_name || '-',
      last_name:   $mes.from.last_name  || '-'
    )
end

def update_user_info_if_changed model_name = 'User'
  model = model_name == 'User' ? $user : $mod
  username_cur =       $mes.from.username
  username_writen =    model.username

  first_name_cur =     $mes.from.first_name
  first_name_written = model.first_name

  last_name_cur =      $mes.from.last_name
  last_name_written =  model.last_name
 
  model.update(username:   username_cur || '-')   if username_cur   != username_writen
  model.update(first_name: first_name_cur || '-') if first_name_cur != first_name_written
  model.update(last_name:  last_name_cur || '-')  if last_name_cur  != last_name_written
end
