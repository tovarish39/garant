# frozen_string_literal: true

def language_selected
  $lg = $mes.data.split('/').first
  $user.update(lang: $lg)
  to_start
  delete_pushed
end

def to_start
  User.update(
    userTo_id: nil,
    role: nil,
    currency: nil,
    amount: nil,
    conditions: nil
  )
  send_message(B_choose_action[$lg], RM_start.call)
end

def view_languages
  send_message(B_choose_language, IM_languages)
  $user.update(lang_viewed: true)
end
