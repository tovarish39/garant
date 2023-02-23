def user_hasnot_active_deals
    send_message(B_none_deals_active[$lang])
end

def deals_active
    $deals_active.each do |deal|
      if  deal.status == 'payed_by_custumer' || deal.status == 'dispute_request'
        if    deal.seller_id == $user.id # self seller
            $userTo = User.find(deal.custumer_id)
            if   deal.status == 'dispute_request'
                send_message(B_deal_full_info.call(deal) + "\n\n" + B_opened_disput[$lang])
            else 
                send_message(B_deal_full_info.call(deal), IM_seller_deal_actions.call(deal))
            end
        elsif deal.custumer_id == $user.id # self custumer
            $userTo = User.find(deal.seller_id)
            if  deal.status == 'dispute_request'
                send_message(B_deal_full_info.call(deal) + "\n\n" + B_opened_disput[$lang])
            else
                send_message(B_deal_full_info.call(deal), IM_custumer_deal_actions.call(deal))
            end
        end
      end
    end
end

def invalid_deal_status
    return
end

def to_await_disput_text
    deal = get_deal()
    send_message(B_couse_disput[$lang], RM_cancel.call)

    $user.update(
        mes_ids_to_edit:[$mes.message.message_id],
        cur_deal_id:deal.id
    )
end