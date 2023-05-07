

def to_add_comment
  $deal = get_deal
  grade = $mes.data.split('/').first

  $deal.update(grade: grade)
  $user.update(cur_deal_id: $deal.id)

  send_message(B_add_comment[$lg], IM_add_comment.call)
end
