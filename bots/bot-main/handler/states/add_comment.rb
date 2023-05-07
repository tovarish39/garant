

def handle_comment
  deal = Deal.find($user.cur_deal_id)
  comment = $mes.text

  deal.update(comment: comment)

  send_message(B_comment_added[$lg], RM_deals_menu.call)
end
