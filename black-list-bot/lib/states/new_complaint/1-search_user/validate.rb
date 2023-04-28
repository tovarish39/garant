# frozen_string_literal: true

# def user_found?
#   if    is_user_shared?
#     telegram_id = $mes.user_shared[:user_id]
#   elsif is_telegram_id?
#     telegram_id = $mes.text
#   elsif is_username?
#     # не сделано
#   end
#   $user.update(cur_scamer_id: telegram_id)
# end

def is_user_shared?
  $mes.user_shared.present? ? true : false
end

# def is_username?
#   false
# end

# def is_telegram_id?
#   input = $mes.text
#   input =~ /^-?\d+$/
# end
