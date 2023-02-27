def user_hasnot_active_deals
    send_message(B_none_deals_active[$lg])
end

def deals_active
    # $user или seller или custumer
    $deals_active.each do |deal| 
      # 
      dispute_active = deal.disputes.select {|dispute| dispute.status == 'in_process'}
      moderator_username = dispute_active.first.moderator.username if dispute_active.size != 0

      if  deal.status == 'payed by_custumer' || deal.status == 'dispute request'
        if    deal.seller_id == $user.id # self seller
            $userTo = User.find(deal.custumer_id)
            if   deal.status == 'dispute request'
                text = B_deal_full_info.call(deal) + "\n\n" + B_opened_disput[$lg]
                text << " \n ведёт @#{moderator_username}" if moderator_username
                send_message(text)
            else
                text =  B_deal_full_info.call(deal)
                text << " \n ведёт @#{moderator_username}" if moderator_username
                send_message(text, IM_seller_deal_actions.call(deal))
            end
        elsif deal.custumer_id == $user.id # self custumer
            $userTo = User.find(deal.seller_id)
            if  deal.status == 'dispute request'
                text = B_deal_full_info.call(deal) + "\n\n" + B_opened_disput[$lg]
                text << " \n ведёт @#{moderator_username}" if moderator_username
                send_message(text)
            else
                text = B_deal_full_info.call(deal)
                text << " \n ведёт @#{moderator_username}" if moderator_username
                send_message(text, IM_custumer_deal_actions.call(deal))
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
    send_message(B_couse_disput[$lg], RM_cancel.call)

    $user.update(
        mes_ids_to_edit:[$mes.message.message_id],
        cur_deal_id:deal.id
    )
end