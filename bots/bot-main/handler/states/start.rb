

# seva - 6016837864

# text нажата "Найти пользователя"
def find_userTo
  send_message(
    B_await_username_or_id[$lg],
    RM_cancel_to_start.call
  )
end

def to_deals_menu
  send_message(B_choose_action[$lg], RM_deals_menu.call)
end
