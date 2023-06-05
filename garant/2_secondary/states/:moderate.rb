class StateMachine
    class_eval do
      include AASM
      aasm do
        state :moderate
  
        event :moderate_action, from: :moderate do

          transitions if: -> {text_mes?('/start')}        , after: :view_menu                 , to: :moderate
          transitions if: -> {text_mes?('Открытые споры')}, after: :list_opened_disputes      , to: :moderate
          transitions if: -> {text_mes?('Мои споры')}     , after: :list_my_inProcess_disputes, to: :moderate
          transitions if: -> {text_mes?('История споров')}, after: :list_my_closed_disputes   , to: :moderate

          transitions if: -> {data?(/Accept/)}            , after: :handle_acception          , to: :moderate # модератор принимает спор
          transitions if: -> {data?(/Decision/) &&  dispute_actual?}          , after: :handle_decision           , to: :comment # seller_lost || custumer_lost || nonobservance
          transitions if: -> {data?(/Decision/) && !dispute_actual?}          , after: :already_handled           , to: :moderate # seller_lost || custumer_lost || nonobservance
        end
      end
    end
  end
  
  def view_menu
    Send.mes(B_choose_action[Ru], M::Reply.moderator_menu)
  end
  
  def get_data_dispute(dispute)
      deal = dispute.deal
      seller   = User.find(deal.seller_id)
      custumer = User.find(deal.custumer_id)
      initiator = dispute.created_by_user_id == seller.id.to_s ? B_by_seller[Ru] : B_by_custumer[Ru]
      { deal: deal, seller: seller, custumer: custumer, initiator: initiator }
    end
  
  def list_opened_disputes
      opened_disputes = Dispute.where(status: 'pending_moderator')
      if opened_disputes.any?
        opened_disputes.each do |dispute|
          data = get_data_dispute(dispute)
    
          Send.mes(
            B_disput_offer.call(data[:seller], data[:custumer], data[:deal], dispute, data[:initiator], Ru),
            M::Inline.dispute_offer(dispute, Ru)
          )
        end
      else
        Send.mes('Открытых споров нет')
      end
    end
  
  
  def list_my_inProcess_disputes
    inProcess_disputes = $mod.disputes.where(status: 'in_process')
    if inProcess_disputes.any?
      inProcess_disputes.each do |dispute|
        data = get_data_dispute(dispute)
        Send.mes(
          B_disput_offer.call(data[:seller], data[:custumer], data[:deal], dispute, data[:initiator], Ru),
          M::Inline.decision_actions(dispute, Ru)
        )
      end
    else
      Send.mes('Все споры обработаны')
    end
  end
  
  def list_my_closed_disputes
      finished_disputes = $mod.disputes.where(status: 'finished')
      if finished_disputes.any?
        finished_disputes.each do |dispute|
          data = get_data_dispute(dispute)
          Send.mes(
            B_disput_offer.call(data[:seller], data[:custumer], data[:deal], dispute, data[:initiator],
                                Ru) + B_dispute_comment.call(dispute)
          )
        end
      else
        Send.mes('Обработаных споров не было')
      end
    end
  
  def search_dispute
    dispute_id = $mes.data.split('/').last
    dispute = Dispute.find_by(id: dispute_id)
  end
  
  def from_redis1 data # модератор принял спор в обработку
      data = data.split(':')
      dispute_id         = data.first
      action             = data.last # 'get-dispute'
      dispute = Dispute.find(dispute_id)
      seller   = User.find(dispute.deal.seller_id)
      custumer = User.find(dispute.deal.custumer_id)
      bot = Telegram::Bot::Client.new(Bot_Token_1_PRIMARY)
      $bot = bot
      moderator_username = dispute.moderator.username
      puts '1'
      [seller, custumer].each do |to_user|
        Send.mes("Спор по сделки ##{dispute.deal.hash_name} ведёт @#{moderator_username}", to:to_user)
      end
      puts '2'

    end
  
  def handle_acception
    dispute = search_dispute
    return unless dispute
  
    # puts dispute.status
    is_actual = dispute.status == 'pending_moderator'
    return unless is_actual
  
    TakenDispute.create!(moderator_id: $mod.id, dispute_id: dispute.id)
    dispute.update(status: 'in_process')

    Delete.pushed
    Send.mes("Спор перенесён во вкладку 'Мои споры'")

    dispute.sended_to_moderators.each do |obj|
      mod_id = obj.keys[0]
      mes_id = obj.values[0]
      # $chat_id = $mes.message.chat.id
  
      begin
        if mod_id == $mod.id.to_s
          Edit.mes("спор по сделки ##{dispute.deal.hash_name} взят вами в обработку", nil,
                       mes_id)
        end
        if mod_id != $mod.id.to_s
          Edit.mes("спор по сделки ##{dispute.deal.hash_name} взят другим модератором в обработку", nil,
                       mes_id)
        end
        $logger.info("#{obj} dispute_id #{dispute.id} ---> edited successfull")
      rescue  => e
        $logger.error("#{dispute.sended_to_moderators.inspect} ---> #{e}")
      end
      from_redis1("#{dispute.id}:get-dispute")
    end
  end
  
  def get_dispute_by_button
      dispute_id = dispute_id = $mes.data.split('/').last
      action     = $mes.data.split('/')[1]
      Dispute.find(dispute_id)
  end

  def dispute_actual?
      dispute = get_dispute_by_button
      dispute.status == 'in_process'
  end

def already_handled

    Delete.pushed
    Send.mes('Cпор был ранее обработан')
end
  
  def handle_decision
      action     = $mes.data.split('/')[1]
      dispute = get_dispute_by_button
    
      $mod.update(
        pushed_IB_mes_id: $mes.message.message_id,
        current_dispute_id: dispute.id,
        pushed_action: action
      )
      $lg = Ru
      Send.mes('Введите комментарий решения, который отобразится Покупателю и Продавцу', M::Reply.cancel)
    end