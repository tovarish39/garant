def handle
  $mod = searching_user('Moderator')             # поиск ранее созданного user по telegram_id
  $mod ||= create_user('Moderator') unless $mod  # создание user, если не найден
  # $lg = $mod.lang
  update_user_info_if_changed('Moderator')

  return if $mod.rights_status != 'active' # админ определил статуc 'active'

  begin
    
  
    if    $mod.username == '-'
      require_username # обязательный юзернейм
    elsif $mes.class  == ChatMemberUpdated # реагирует только от private chat
    elsif ($mes.class == CallbackQuery) || ($mes.class == Message)
      # $chat_id = ($mes.class == Message) ? $mes.chat.id : $mes.message.chat.id # после UpdatedChatMember
      # from_state = :moderate           # предидущее состояние
      from_state = $mod.aasm_state.to_sym           # предидущее состояние
      event_bot = StateMachine.new

      # after_info

      event_bot.aasm.current_state = from_state
      event_bot.method("#{from_state}_action").call # event = #{from_state}_action

      # before_info
      new_state = event_bot.aasm.current_state
      $mod.update(aasm_state: new_state)            # запись нового состояния
    end
  rescue => exception
    puts exception
    puts exception.backtrace
  end

end










