# frozen_string_literal: true

def search_dispute
  dispute_id = $mes.data.split('/').last
  dispute = Dispute.find_by(id: dispute_id)
end

def require_username
  send_message('Для продолжения работы укажите свой "username"')
end

def handle_acception
  dispute = search_dispute
  return unless dispute

  # puts dispute.status
  is_actual = dispute.status == 'pending_moderator'
  return unless is_actual

  TakenDispute.create!(moderator_id: $mod.id, dispute_id: dispute.id)
  dispute.update(status: 'in_process')

  dispute.sended_to_moderators.each do |obj|
    mod_id = obj.keys[0]
    mes_id = obj.values[0]
    $chat_id = $mes.message.chat.id

    begin
      if mod_id == $mod.id.to_s
        edit_message("спор по сделки ##{dispute.deal.hash_name} взят вами в обработку", nil,
                     mes_id)
      end
      if mod_id != $mod.id.to_s
        edit_message("спор по сделки ##{dispute.deal.hash_name} взят другим модератором в обработку", nil,
                     mes_id)
      end
      $logger.info("#{obj} dispute_id #{dispute.id} ---> edited successfull")
    rescue StandardError => e
      $logger.error("#{dispute.sended_to_moderators.inspect} ---> #{e}")
    end
    system("redis-cli publish two #{dispute.id}:get-dispute")
  end
  delete_pushed
  send_message("Спор перенесён во вкладку 'Мои споры'")
end

def view_menu
  send_message(B_choose_action[Ru], RM.call(['Открытые споры', 'Мои споры', 'История споров']))
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
  if !opened_disputes.empty?
    opened_disputes.each do |dispute|
      data = get_data_dispute(dispute)

      send_message(
        B_disput_offer.call(data[:seller], data[:custumer], data[:deal], dispute, data[:initiator], Ru),
        IM_dispute_offer.call(dispute, Ru)
      )
    end
  elsif opened_disputes.empty?
    send_message('Открытых споров нет')
  end
end

def list_my_inProcess_disputes
  inProcess_disputes = $mod.disputes.where(status: 'in_process')
  if !inProcess_disputes.empty?
    inProcess_disputes.each do |dispute|
      data = get_data_dispute(dispute)
      send_message(
        B_disput_offer.call(data[:seller], data[:custumer], data[:deal], dispute, data[:initiator], Ru),
        IM_decision_actions.call(dispute, Ru)
      )
    end
  elsif inProcess_disputes.empty?
    send_message('Все споры обработаны')
  end
end

def handle_decision
  dispute_id = dispute_id = $mes.data.split('/').last
  action     = $mes.data.split('/')[1]
  dispute    = Dispute.find(dispute_id)
  return if dispute.status != 'in_process' # был ранее обработан

  $mod.update(
    state: 'pending_comment',
    pushed_IB_mes_id: $mes.message.message_id,
    current_dispute_id: dispute_id,
    pushed_action: action
  )
  send_message('Введите комментарий решения, который отобразится Покупателю и Продавцу', RM.call('Отмена'))
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
    system("(redis-cli publish two #{dispute.id}:push-decision &)")
  end
  $mod.update(
    state: nil,
    pushed_IB_mes_id: nil,
    current_dispute_id: nil,
    pushed_action: nil
  )
end

def list_my_closed_disputes
  finished_disputes = $mod.disputes.where(status: 'finished')
  if !finished_disputes.empty?
    finished_disputes.each do |dispute|
      data = get_data_dispute(dispute)
      send_message(
        B_disput_offer.call(data[:seller], data[:custumer], data[:deal], dispute, data[:initiator],
                            Ru) + B_dispute_comment.call(dispute)
      )
    end
  elsif finished_disputes.empty?
    send_message('Обработаных споров не было')
  end
end
