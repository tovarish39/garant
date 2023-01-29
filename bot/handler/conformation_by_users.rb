def seller? deal
    $user.id == deal.seller_user_id
  end
  
  def custumer? deal
    $user.id == deal.custumer_user_id
  end
  

  
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
  
  # seller|custumer action 
  def handle_deal_request
    puts 'seller|custumer action '
    deal_id = $mes.data.split('/')[2]
    action_to_request = $mes.data.split('/')[1]
    deal = Deal.find(deal_id)
    return unless deal.state =~ /request_to/# || deal.state =~ /accessed_by/# если запрос на deal был ранее обработан
  
    seller   = find_seller(deal)
    custumer = find_custumer(deal)
puts "seller = #{seller.telegram_id}"

    case action_to_request
    when  'Принять'
      if   seller?(deal)
puts 'seller access'
        deal.update(state:"accessed_by seller-user_id: #{$user.id}")
        send_message(TB_pending_pay_from_custumer[$lang]) # сообщение to_seller об отправке запроса на оплату to_custumer
        send_message_to_user(TB_response_pay.call(deal, $user, $lang), custumer, M_pay_cancel.call(deal)) # сообщение с предложением оплаты to_custumer 
      elsif custumer?(deal)
        # deal.update(state:"accessed by custumer-user_id: #{$user.id}")
        deal_payed_and_notifing(deal, seller)
      end
    when  'Отклонить'
      if seller?(deal)
        rejecting_deal(deal, seller)
      elsif custumer?(deal)
        rejecting_deal(deal, custumer)
      end
    end
  end
  
  # custumer action 
  def handle_by_custumer
    puts 'custumer action '

    deal_id = $mes.data.split('/')[2]
    action_to_request = $mes.data.split('/')[1]
    deal = Deal.find(deal_id)
    return unless deal.state =~ /accessed_by seller/ # если запрос на deal был ранее обработан
  
    seller   = find_seller(deal)
    custumer = find_custumer(deal)
puts "seller = #{seller.telegram_id}"
    case action_to_request
    when  'cancel deal'
      rejecting_deal(deal, custumer)
    when  'pay'
      result = try_paying()
      if result 
        deal_payed_and_notifing(deal, seller)
      end
    end
  end
  
  
  def rejecting_deal deal, user_from
    puts 'reject_deal'
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