# frozen_string_literal: true

def try_paying
  true
end

# seller || custumer приняли предложение сделки в ответ после создания сделки
def accepting_deal
  deal_id = $mes.data.split('/').last
  $deal = Deal.find(deal_id)
  return unless $deal.status =~ /accessed/ || $deal.status.nil?

  self_seller   = $user.id == $deal.seller_id
  self_custumer = $user.id == $deal.custumer_id

  if    self_seller # подтверждение и отправка покупателю запрос на оплату
    $userTo = User.find($deal.custumer_id)
    $deal.update(status: 'accessed by_seller')
    send_message_to_user(B_request_deal_to_custumer.call, $userTo, IM_accept_reject.call)
    send_message(B_request_deal_self.call)
  elsif self_custumer # оплата покупателем и status:payed
    # перевод средств от custumer
    result = try_paying
    if result
      $userTo = User.find($deal.seller_id)
      $deal.update(status: 'payed by_custumer')
      send_message(B_notify_to_custumer_success_payed[$lg])
      send_message_to_user(B_notifi_to_seller_success_payed.call, $userTo)
    end
  end
end

# seller || custumer отменил предложенную сделку
def rejecting_deal
  deal_id = $mes.data.split('/').last
  $deal = Deal.find(deal_id)

  self_seller   = $user.id == $deal.seller_id
  self_custumer = $user.id == $deal.custumer_id

  if    self_seller
    $userTo = User.find($deal.custumer_id)
    $deal.update(status: 'rejected by_seller')
  elsif self_custumer
    $userTo = User.find($deal.seller_id)
    $deal.update(status: 'rejected by_custumer')
  end

  send_message_to_user(B_reject_deal_userTo.call, $userTo)
  send_message(B_reject_deal_self[$lg])
end
