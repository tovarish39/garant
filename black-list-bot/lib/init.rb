# frozen_string_literal: true

def user_search_and_update_if_changed model = 'user'
  user = BlackListUser     .find_by(telegram_id: $mes.from.id) if model == 'user'
  user = BlackListModerator.find_by(telegram_id: $mes.from.id) if model == 'moderator'

  return false if user.nil?

  username_now    = $mes.from.username
  username_writen = user.username
  user.update(username: username_now || '-') if username_now != username_writen
  user
end

def create_user model = 'user'
  user = BlackListUser.create!(
    telegram_id: $mes.from.id,
    username: $mes.from.username || '-'
  ) if model == 'user'

  user = BlackListModerator.create!(
    telegram_id: $mes.from.id,
    username: $mes.from.username || '-'
  ) if model == 'moderator'
  user
end
