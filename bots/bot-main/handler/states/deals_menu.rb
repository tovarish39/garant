##############################
###### deal statuses: ########
# nil                   "Запросы"        -> отправлено на согласование
# rejected by_seller    "История сделок" -> отклонено продавцом   на стадии запроса на подтверждения
# rejected by_custumer  "История сделок" -> отклонено покупателем на стадии запроса на подтверждения
# accessed by_seller    "Запросы"        -> продавец подтвердил предложение сделки созданной покупателем
# payed by_custumer     "Активные"       -> покупатель оплатил сделку
# dispute request       "Споры"          -> по сделке открыт спор
# finished by_seller    "История сделок" -> отклонено продавцом,        средства переведены покупателю
# finished by_custumer  "История сделок" -> покупатель завершил сделку, средства переведены продавцу
# finished by_moderator "История сделок" -> сделку завершил модератор через разрешение спора,
#                                        средства переведены в зависимости от решения --- продавцу || покупателю || никому
def hasnot_active_deals  = send_message(B_none_active_deals[$lg])
def hasnot_request_deals = send_message(B_none_request_deals[$lg])
def hasnot_dispute_deals = send_message(B_none_dispute_deals[$lg])
def hasnot_history_deals = send_message(B_none_history_deals[$lg])

def self_seller?   = $deal.seller_id   == $user.id 
def self_custumer? = $deal.custumer_id == $user.id 
def get_userTo_from_exist_deal     = self_seller?() ? User.find($deal.custumer_id) : User.find($deal.seller_id) 




def view_active_deals #  statuses: =~ /payed/
    $active_deals.each do |deal|
        $deal = deal
        $userTo = get_userTo_from_exist_deal()

        send_message(
            B_deal_verbose.call('with_custumer'), 
            IM_seller_deal_actions.call  
            ) if self_seller?()

        send_message(
            B_deal_verbose.call('with_seller'), 
            IM_custumer_deal_actions.call
            ) if self_custumer?()
    end
end

def view_request_deals #  statuses: nil || =~ /accessed/ 
    $request_deals.each do |deal|
        $deal = deal
        $userTo = get_userTo_from_exist_deal()
# status nil
        if $deal.status.nil?
            send_message(
                B_deal_verbose.call('with_custumer'),   
                ) if self_seller?()

            send_message(
                B_deal_verbose.call('with_seller'), 
                ) if self_custumer?()
# status /accessed/
        elsif $deal.status =~ /accessed/
            send_message(
                B_deal_verbose.call('with_custumer'),   
                ) if self_seller?()

            send_message(
                B_deal_verbose.call('with_seller'),
                IM_accept_reject.call 
                ) if self_custumer?()
        end
    end
end   

def view_dispute_deals #  statuses: nil || =~ /accessed/ 
    $dispute_deals.each do |deal|
        $deal = deal
        $userTo = get_userTo_from_exist_deal()

        send_message(
            B_deal_verbose.call('with_custumer'),   
            # IM_custumer_deal_actions.call
            ) if self_seller?()

        send_message(
            B_deal_verbose.call('with_seller'), 
            # IM_accept_reject.call
            ) if self_custumer?()
    end
end 

def view_history_deals # statuses: == 'rejected by_seller' || == 'rejected by_custumer' || == 'canceled by_custumer' || == 'finished by_custumer' || == 'finished by_moderator'
    $history_deals.each do |deal|
        $deal = deal
        $userTo = get_userTo_from_exist_deal()
        
# если сделка завершилась через спор
        dispute = $deal.disputes.first if !$deal.disputes.empty? 
        if dispute && dispute.status == 'finished'
            $moderators_username  = dispute.moderator.username
            $comment_by_moderator = dispute.comment_by_moderator
        end
# сделку отменил или завершил или "гарант"         администратор
        if dispute && dispute.status == nil
            $comment_by_administrator = dispute.comment_by_moderator
        end

        send_message(
            B_deal_verbose.call('with_custumer')
            ) if self_seller?()


        send_message(
            B_deal_verbose.call('with_seller')
            ) if self_custumer?()
    end
end


def invalid_deal_status = send_message("ранее был открыт спор или продавец отменил сделку или сделка была завершена")

def finishing_deal_by_custumer
    $deal = get_deal()
    
    $seller   = User.find($deal.seller_id)
    $custumer = User.find($deal.custumer_id)
    
    # кошелёк продавца
    sellers_wallet =  $seller.wallet
    currency = $deal.currency
    amount   = $deal.amount

    # обновление кошелька Продавца в определённой валюте
    sellers_wallet.key?(currency) ?  sellers_wallet[currency] = sellers_wallet[currency].to_i + amount.to_i : sellers_wallet[currency] = amount.to_i
    $seller.save

    $deal.update(status:'finished by_custumer')
    # сообщение Продавцу и Покупателю
    [$seller, $custumer].each {|user| send_message_to_user(B_deal_canceled_or_finished.call, user)}

    send_message(B_add_grade[$lg], IM_add_grade.call)
end

def canceled_deal_by_seller
    $deal = get_deal()
    
    $seller   = User.find($deal.seller_id)
    $custumer = User.find($deal.custumer_id)
    
    # кошелёк Покупателя
    custumers_wallet =  $custumer.wallet
    
    
    currency = $deal.currency
    amount   = $deal.amount
    
    # обновление кошелька Покупателя в определённой валюте
    custumers_wallet.key?(currency) ? custumers_wallet[currency] = custumers_wallet[currency].to_i + amount.to_i : custumers_wallet[currency] = amount.to_i
    
    $custumer.save
    
    $deal.update(status:'canceled by_seller')
# сообщение Продавцу и Покупателю
    [$seller, $custumer].each {|user| send_message_to_user(B_deal_canceled_or_finished.call, user)}
end

def to_await_disput_text
    deal = get_deal()
    send_message(B_couse_disput[$lg], RM_cancel.call)

    $user.update(
        mes_ids_to_edit:[$mes.message.message_id],
        cur_deal_id:deal.id
    )
end