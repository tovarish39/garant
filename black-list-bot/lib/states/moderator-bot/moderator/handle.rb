def greeting_mod
    Send.mes(Text.greeting_mod, M::Reply.greeting_mod)
end

def view_complaints
    scamer_complaints = Scamer.all.filter {|scamer| scamer.status == 'to_moderator'}
    user_justifications = BlackListUser.where.not(justification:nil)

    scamer_complaints.each do |scamer|
        user = scamer.black_list_user
        Send.mes(
            Text.moderator_complaint(user, scamer), 
            M::Inline.moderator_complaint(scamer),
        )
    end
    user_justifications.each do |user|
        accepted_scamers = Scamer.where(telegram_id:user.telegram_id).filter {|scamer| scamer.status == 'accepted_complaint'}
        Send.mes(
            Text.justification_request_to_moderator(accepted_scamers),
            M::Inline.justification_request_to_moderator(user)
        )
    end

    Send.mes(Text.not_complaints) if scamer_complaints.empty? && user_justifications.empty?
end

def publishing_in_channel
end

def get_scamer_by_button
    scamer_id = $mes.data.split("/").first
    scamer = Scamer.find_by(id:scamer_id)
end

def update_or_create_black_list_user_whith_scamer_status scamer
    user = BlackListUser.find_by(telegram_id:scamer.telegram_id)
    if user.present?
        user.update(
            is_self_scamer:true
        )
    else
        BlackListUser.create!(
            telegram_id:   scamer.telegram_id,
            is_self_scamer:true
        )
    end
end

def handle_accept_complaint
    scamer = get_scamer_by_button()
    return if scamer.nil?
    already_handled = scamer.status != "to_moderator"
    if already_handled
        Send.mes(Text.was_handled)
    else
        scamer.update(status:'accepted_complaint')
        publishing_in_channel
        update_or_create_black_list_user_whith_scamer_status(scamer)
        Send.mes(Text.handle_accept_complaint)
        black_list_bot = Telegram::Bot::Client.new(TOKEN_BOT)
        black_list_bot.api.send_message(
            text:Text.complaint_published(scamer),
            chat_id:scamer.black_list_user.telegram_id
        )
    end
end

def handle_reject_complaint
    scamer = get_scamer_by_button()
    return if scamer.nil?
    already_handled = scamer.status != "to_moderator"
    if already_handled
        Send.mes(Text.was_handled)
    else
        $user.update(cur_scamer_id:scamer.id)
        Send.mes(Text.input_cause_of_reject)
    end
end

def get_user_by_button
    user_id = $mes.data.split("/").first
    user = BlackListUser.find(user_id)
end

def send_notify_to user, text
    main_bot = Telegram::Bot::Client.new(TOKEN_BOT)
    main_bot.api.send_message(
        chat_id:user.telegram_id,
        text:text
    )
end

def accessing_justification
    user = get_user_by_button()
    return if user.is_self_scamer == false # уже обработан
    
    accessed_scamers = Scamer.where(telegram_id:user.telegram_id).where(status:'accepted_complaint')
    accessed_scamers.update_all(status:"rejected_complaint")

    user.update!(
        is_self_scamer:false,
        state_aasm:'start',
        justification:nil
    )

    Send.mes(Text.accessing_justification)
    send_notify_to(user, Text.you_not_scamer)


end
def blocking_user
    user = get_user_by_button()
    return if user.is_self_scamer == false # уже обработан

    user.update!(
        is_blocked_by_moderator:true
    )

    Send.mes(Text.blocking_user)
    send_notify_to(user, Text.you_blocked)

end