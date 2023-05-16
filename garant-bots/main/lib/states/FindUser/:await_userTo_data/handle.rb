def userTo_not_found
    send_message(B_userTo_not_found[$lg])  if text_mes? # при вводе telegram_id || username
    send_message(B_userTo_not_subscr[$lg]) if user_shared? # при выборе из списка контактов
  end
  


def formatted_avarage_num numbers
  avarage = (numbers.sum.to_f /  numbers.size).round(1)
  "#{avarage}/5"
end

def get_reiting_userTo
  whith_reiting = Deal.with_reiting($userTo)
  if whith_reiting.any?
    marks = whith_reiting.map(&:grade).map(&:to_i)
    formatted_avarage_num(marks)
  else 
    nil 
  end
end

def run_to_userTo
    # puts user_shared? &&  bot_has_userTo?
    # puts text_mes? && bot_has_userTo?
# puts $userTo

  userTo = User.find($user.userTo_id)
  $user.update(
    userTo_id: userTo.id,
    role: nil,
    currency: nil,
    amount: nil,
    conditions: nil
  )

  closed_deals = Deal.closed_statuses(DEAL_Closed_Statuses)

  userTo_as_seller_of_closed_deals   = closed_deals.as_seller($userTo)
  userTo_as_customer_of_closed_deals = closed_deals.as_customer($userTo) 

  userTo_comments = userTo_as_seller_of_closed_deals.with_comment
  # userTo_disputes = closed_deals.as_seller_OR_as_customer($userTo).filter {|deal| deal.disputes.any? } 
  userTo_deals_raw = closed_deals.as_seller_OR_as_customer($userTo)
  
  userTo_disputes = [] 
  
  userTo_deals_raw.each do |deal| 
    if deal.disputes.any? 
      dispute = deal.disputes[0]
      userTo_disputes  << dispute if (dispute.dispute_lost == 'seller_lost') || (dispute.dispute_lost == 'custumer_lost')
    end
  end

  



  userTo_reiting  = get_reiting_userTo()

  send_message(B_info[$lg], RM_start.call)
  send_message(
    B_userTo_info.call(
      userTo_as_seller_of_closed_deals.size, 
      userTo_as_customer_of_closed_deals.size, 
      userTo_reiting
      ), 
    IM_offer_deal.call(
      userTo_comments.size,
      userTo_disputes.size
    )
  )
end

def cancel
  to_start
end