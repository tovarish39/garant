class StateMachine
    class_eval do
      include AASM
      aasm do
        state :comment
  
        event :comment_action, from: :comment do
          transitions if: -> {text_mes?}, after: :finishing_dispute,   to: :moderate
        end
      end
    end
end
  
  def from_redis2 data # модератор определил решение по спору
    data = data.split(':')
    dispute_id         = data.first
    action             = data.last # 'get-dispute'
    dispute = Dispute.find(dispute_id)
    seller   = User.find(dispute.deal.seller_id)
    custumer = User.find(dispute.deal.custumer_id)
    bot = Telegram::Bot::Client.new(Bot_Token_1_PRIMARY)
    $bot = bot.api
  
    decision = dispute.dispute_lost # 'seller_lost' || 'custumer_lost' || 'all_lost'
    currency = dispute.deal.currency
    amount   = dispute.deal.amount
  
    case decision
    when 'seller_lost'
      custumers_wallet = custumer.wallet
      # обновление кошелька Покупателя в определённой валюте
      custumers_wallet[currency] = if custumers_wallet.key?(currency)
                                     custumers_wallet[currency].to_i + amount.to_i
                                   else
                                     amount.to_i
                                   end
      custumer.save
    when 'custumer_lost'
      sellers_wallet = seller.wallet
      # обновление кошелька Покупателя в определённой валюте
      sellers_wallet[currency] = if sellers_wallet.key?(currency)
                                   sellers_wallet[currency].to_i + amount.to_i
                                 else
                                   amount.to_i
                                 end
      seller.save
    when 'all_lost'
    end
  
    text = "Спор по сделке ##{dispute.deal.hash_name} \n"
    text += B_dispute_comment.call(dispute)
    [seller, custumer].each { |to_user| send_message_to_user(text, to_user) }
  end
  
  def finishing_dispute
    # отменить решение о споре на моменте комментария
    if    text_mes?('Отмена')
      view_menu
      # завершение спора после комментария
    elsif text_mes?
      dispute = Dispute.find($mod.current_dispute_id)
      comment = $mes.text
  
      # $mod.pushed_action реакция на платёжку
  
      dispute.deal.update(status: 'finished by_moderator')
      dispute.update(
        comment_by_moderator: comment,
        status: 'finished',
        dispute_lost: $mod.pushed_action
      )
      delete_pushed($mod.pushed_IB_mes_id)
      send_message("спор по сделке ##{dispute.deal.hash_name} обработан",
                   RM.call(['Открытые споры', 'Мои споры', 'История споров']))
      from_redis2("#{dispute.id}:push-decision")
    end
    $mod.update(
      pushed_IB_mes_id: nil,
      current_dispute_id: nil,
      pushed_action: nil
    )
  end