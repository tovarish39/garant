# seva - 6016837864

# text нажата "Найти пользователя"
def find_userTo
  send_message(
    B_await_username_or_id[$lang],
    RM_cancel_to_start.call
  )
end