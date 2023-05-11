# frozen_string_literal: true

def user_search_and_update_if_changed class_name
  klass = class_name.constantize
  user = klass.find_by(telegram_id: $mes.from.id)
  return false if user.nil?

  username_now    = $mes.from.username
  username_writen = user.username
  user.update(username: username_now || '-') if username_now != username_writen
  user
end

def create_user class_name
  klass = class_name.constantize
  klass.create!(
    telegram_id: $mes.from.id,
    username: $mes.from.username || '-'
  ) 
end
