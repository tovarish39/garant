def create_dispute
    deal = Deal.find($user.cur_deal_id)
    deal.update(status:'dispute_request')
    dispute = deal.disputes.create(
        created_by_user_id:$user.id,
        content:$mes.text.strip
    )
    userTo_id = deal.seller_id == $user.id ? deal.custumer_id : deal.seller_id
    $userTo = User.find(userTo_id) 
    
    edit_message((B_deal_full_info.call(deal) + "\n\n" + B_opened_disput[$lang]), nil, $user.mes_ids_to_edit[0])
    send_message(B_request[$lang], RM_deals_menu.call)
    system("(redis-cli publish one #{dispute.id} &)")
end