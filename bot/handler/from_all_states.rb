def try_paying
  true
end

def find_custumer deal
  User.find(deal.custumer_user_id)
end

def find_seller(deal)
  User.find(deal.seller_user_id)
end

def deal_payed_and_notifing deal, seller
  deal.update(state:'payed')
  send_message(TB_notify_to_custumer_success_payed[$lang])
  send_message_to_user(TB_notifi_to_seller_success_payed.call(deal, seller, $lang), seller)
end


def get_data
  deal_id  = $mes.data.split('/')[2]
  action   = $mes.data.split('/')[1]
  deal = Deal.find(deal_id)
  seller   = find_seller(deal)
  custumer = find_custumer(deal)
  
  {action:  action,
   deal:    deal,
   seller:  seller,
   custumer:custumer
  }
end


# seller action 
def handle_response_by_seller
  data = get_data() # action, deal, seller, custumer
  deal = data[:deal]

  return unless deal.state =~ /request_to seller/# если запрос был ранее обработан

  case data[:action]
  when  'Принять'
      send_message(Request_deal.call(deal, $lang)) # уведомление об отправке запроса продавцу
      send_message_to_user(Request_deal_to_user.call(deal, $user, $lang), data[:custumer], M_accept_reject_by_custumer.call(deal))
      deal.update(state: 'request_to custumer')
      deal_payed_and_notifing(deal, data[:seller])
  when  'Отклонить'
      rejecting_deal(deal, data[:custumer])
  end
end

# custumer action 
def handle_response_by_custumer

  data = get_data() # action, deal, seller, custumer
  deal = data[:deal]

  return unless deal.state =~ /request_to custumer/ # если запрос  был ранее обработан

  case data[:action]
  when  'pay'
    result = try_paying()
    if result 
      deal_payed_and_notifing(deal, data[:seller])
    end
  when  'cancel deal'
    rejecting_deal(deal, data[:custumer])
  end  
end


def rejecting_deal deal, user_from
  deal.update(state:"rejected by user_id: #{user_from.id}")
  custumer = User.find(deal.custumer_user_id)
  seller   = User.find(deal.seller_user_id)
  if seller?(deal)
    send_message(BT_reject_deal_self[$lang])
    send_message_to_user(BT_reject_deal_to_from_user.call(deal, $user, $lang), custumer)
  elsif custumer?(deal)
    send_message(BT_reject_deal_self[$lang])
    send_message_to_user(BT_reject_deal_to_from_user.call(deal, $user, $lang), seller)
  end
end