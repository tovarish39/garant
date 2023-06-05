class StateMachine
    class_eval do
      include AASM
      aasm do
        state :deals_menu
  
        event :deals_menu_action, from: :deals_menu do
          ## 'Открыть спор'
          transitions if: -> { data?(/Open_disput/) && valid_deal_status? }, after: :to_await_disput_text, to: :await_disput_text
          transitions if: -> { data?(/Open_disput/) && !valid_deal_status?}, after: :invalid_deal_status, to: :deals_menu # "Открыть спор" уже была кем-то нажата
          ## 'Подтвердить'  покупатель подтверждает окончание сделки, средства переводятся продавцу
          transitions if: -> { data?(/Finish_deal/) && valid_deal_status?}, after: :finishing_deal_by_custumer, to: :marking_deal
          transitions if: -> {data?(/Finish_deal/) && !valid_deal_status?}, after: :invalid_deal_status, to: :deals_menu # "Открыть спор" уже была кем-то нажата
          ## "Отменить сделку" продавец отменяет сделку, средства переводятся покупателю
          transitions if: -> {data?(/Cancel_exist_deal/) && valid_deal_status?}, after: :canceled_deal_by_seller, to: :deals_menu
          transitions if: -> {data?(/Cancel_exist_deal/) && !valid_deal_status?}, after: :invalid_deal_status, to: :deals_menu # "Открыть спор" уже была кем-то нажата
    
          ## 'Активные'
          transitions if: -> {text_mes?(T_active[$lg]) && !has_active_deals?}, after: :hasnot_active_deals,  to: :deals_menu #  отсутствуют
          transitions if: -> {text_mes?(T_active[$lg]) && has_active_deals?}, after: :view_active_deals,    to: :deals_menu # присутствуют
          ## 'Запросы'
          transitions if: -> {text_mes?(T_requests[$lg]) && !has_request_deals?}, after: :hasnot_request_deals, to: :deals_menu #  отсутствуют
          transitions if: -> {text_mes?(T_requests[$lg]) && has_request_deals?}, after: :view_request_deals, to: :deals_menu # присутствуют
          ## 'Споры'
          transitions if: -> {text_mes?(T_disputes[$lg]) && !has_dispute_deals?}, after: :hasnot_dispute_deals, to: :deals_menu #  отсутствуют
          transitions if: -> {text_mes?(T_disputes[$lg]) && has_dispute_deals?}, after: :view_dispute_deals, to: :deals_menu # присутствуют
          ## 'История сделок'
          transitions if: -> {text_mes?(T_deals_history[$lg]) && !has_history_deals?}, after: :hasnot_history_deals, to: :deals_menu #  отсутствуют
          transitions if: -> {text_mes?(T_deals_history[$lg]) && has_history_deals?}, after: :view_history_deals, to: :deals_menu # присутствуют
          ## 'Назад'
          transitions if: -> {text_mes?(T_back[$lg])}, after: :to_start, to: :start # "Назад"
        end
      end
    end
  end
  
  def has_history_deals? 
    # statuses: 
    # == 'rejected by_seller' 
    # == 'rejected by_custumer' 
    # == 'canceled by_custumer' 
    # == 'finished by_custumer' 
    # == 'finished by_moderator'
    
    # == 'garant win by_administrator'
      all_deals_for_user = get_all_deals_for_user()  
      $history_deals = all_deals_for_user.filter do |deal| 
        status = deal.status
        status =~ /rejected/ || status =~ /canceled/ || status =~ /finished/ || status =~ /garant/
      end
      $history_deals.empty? ? false : true
    end
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
def hasnot_active_deals  = Send.mes(B_none_active_deals[$lg])
  def hasnot_request_deals = Send.mes(B_none_request_deals[$lg])
  def hasnot_dispute_deals = Send.mes(B_none_dispute_deals[$lg])
  def hasnot_history_deals = Send.mes(B_none_history_deals[$lg])
  
  def self_seller?   = $deal.seller_id   == $user.id 
  def self_custumer? = $deal.custumer_id == $user.id 
  def get_userTo_from_exist_deal     = self_seller?() ? User.find($deal.custumer_id) : User.find($deal.seller_id) 
  
  
  
  
  def view_active_deals #  statuses: =~ /payed/
      $active_deals.each do |deal|
          $deal = deal
          $userTo = get_userTo_from_exist_deal()
  
          Send.mes(
              B_deal_verbose.call('with_custumer'), 
              M::Inline.seller_deal_actions  
              ) if self_seller?()
  
          Send.mes(
              B_deal_verbose.call('with_seller'), 
              M::Inline.custumer_deal_actions
              ) if self_custumer?()
      end
  end
  
  def view_request_deals #  statuses: nil || =~ /accessed/ 
      $request_deals.each do |deal|
          $deal = deal
          $userTo = get_userTo_from_exist_deal()
  # status nil
          if $deal.status.nil?
              Send.mes(
                  B_deal_verbose.call('with_custumer'),   
                  ) if self_seller?()
  
              Send.mes(
                  B_deal_verbose.call('with_seller'), 
                  ) if self_custumer?()
  # status /accessed/
          elsif $deal.status =~ /accessed/
              Send.mes(
                  B_deal_verbose.call('with_custumer'),   
                  ) if self_seller?()
  
              Send.mes(
                  B_deal_verbose.call('with_seller'),
                  M::Inline.accept_rejects 
                  ) if self_custumer?()
          end
      end
  end   
  
  def view_dispute_deals #  statuses: nil || =~ /accessed/ 
      $dispute_deals.each do |deal|
          $deal = deal
          $userTo = get_userTo_from_exist_deal()
  
          Send.mes(
              B_deal_verbose.call('with_custumer'),   
              # M::Inline.custumer_deal_actions
              ) if self_seller?()
  
          Send.mes(
              B_deal_verbose.call('with_seller'), 
              # M::Inline.accept_reject
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
  
          Send.mes(
              B_deal_verbose.call('with_custumer')
              ) if self_seller?()
  
  
          Send.mes(
              B_deal_verbose.call('with_seller')
              ) if self_custumer?()
      end
  end
  
  
  def invalid_deal_status = Send.mes("ранее был открыт спор или продавец отменил сделку или сделка была завершена")
  
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
      [$seller, $custumer].each {|user| Send.mes(B_deal_canceled_or_finished.call, to:user)}
  
      Send.mes(B_add_grade[$lg], M::Inline.add_grade)
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
      [$seller, $custumer].each {|user| Send.mes(B_deal_canceled_or_finished.call, to:user)}
  end
  
  def to_await_disput_text
      deal = get_deal()
      Send.mes(B_couse_disput[$lg], M::Reply.cancel)
  
      $user.update(
          mes_ids_to_edit:[$mes.message.message_id],
          cur_deal_id:deal.id
      )
  end