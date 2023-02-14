def confirming
  $user.update(conditions:$mes.text)
  $to_user = User.find($user.to_user_id)

  send_message(Confirm_deal.call($user, $to_user, $lang), Confirm_deal_markup.call)
end