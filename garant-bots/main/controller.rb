def handle
  $user = searching_user              # поиск ранее созданного user
  $user ||= create_user unless $user  # создание user, если не найден
  $lg = $user.lang
  update_user_info_if_changed         # обновление информации о user, если изменил
  $chat_id = $mes.instance_of?(MessageClass) ? $mes.chat.id : $mes.message.chat.id

  # юзер заблокировал|разблокировал бота
  if    $mes.instance_of?(UpdateMember)
    new_status = $mes.new_chat_member.status
    $user.update(with_bot_status: new_status) if new_status == 'member'
    $user.update(with_bot_status: new_status) if new_status == 'kicked'
  # при любом состоянии     не изменяя состояние
  elsif $lg && data?(/Reject/); rejecting_deal # отклонение    сделки seller || custumer
  elsif $lg && data?(/Accept/); accepting_deal # подтверждение сделки seller || custumer
  # при определённом состоянии изменяя состояние
  else
    from_state = if !$lg
                   'language'.to_sym # язык не выбран, перевод в "language" состояние
                 elsif click_main_button_or_start?
                   'start'.to_sym # кликнута главная кнопка меню или '/start', перевод в "start" состояние
                 else
                   $user.aasm_state.to_sym # предидущее состояние
                 end
    event_bot = StateMachine.new

    event_bot.aasm.current_state = from_state
    event_bot.method("#{from_state}_action").call # event = #{from_state}_action

    new_state = event_bot.aasm.current_state
    $user.update(aasm_state: new_state)                  # запись нового состояния
  end
end
