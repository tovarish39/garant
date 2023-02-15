def to_confirming
  $user.update(conditions:$mes.text)
  $userTo = User.find($user.userTo_id)

  send_message(B_confirm_deal.call, IM_confirm_deal.call)
end

