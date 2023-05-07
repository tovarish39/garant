

def create_dispute
  $deal = Deal.find($user.cur_deal_id)
  $deal.update(status: 'dispute request')
  dispute = $deal.disputes.create(
    created_by_user_id: $user.id,
    content: $mes.text.strip,
    status: 'pending_moderator'
  )
  self_role = $user.role
  with = 'with_custumer' if self_role == 'I`m seller'
  with = 'with_seller'   if self_role == 'I`m custumer'
  userTo_id = $deal.seller_id == $user.id ? $deal.custumer_id : $deal.seller_id
  $userTo = User.find(userTo_id)
  send_message_to_user("#{B_deal_verbose.call(with, $user)}\n\n#{B_opened_disput[$lg]}", $userTo)
  edit_message("#{B_deal_verbose.call(with)}\n\n#{B_opened_disput[$lg]}", nil, $user.mes_ids_to_edit[0])
  send_message(B_request[$lg], RM_deals_menu.call)
  system("(redis-cli publish one #{dispute.id} &)")
end
