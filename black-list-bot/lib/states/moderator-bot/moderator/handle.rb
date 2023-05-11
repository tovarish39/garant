def greeting_mod
    Send.mes(Text.greeting_mod, M::Reply.greeting_mod)
end

def view_complaints
    complaints_to_moderator = Complaint.all.filter {|complaint| complaint.status == 'to_moderator'}
    userTo_justifications = BlackListUser.where.not(justification:nil)&.where(is_blocked_by_moderator:false)

    complaints_to_moderator.each do |complaint|
        userFrom = complaint.black_list_user
        Send.mes(
            Text.moderator_complaint(userFrom, complaint), 
            M::Inline.moderator_complaint(complaint),
        )
    end
    userTo_justifications.each do |userTo|
        accepted_complaints = Complaint.where(telegram_id:userTo.telegram_id).filter {|complaint| complaint.status == 'accepted_complaint'}
        Send.mes(
            Text.justification_request_to_moderator(accepted_complaints),
            M::Inline.justification_request_to_moderator(userTo)
        )
    end

    Send.mes(Text.not_complaints) if complaints_to_moderator.empty? && userTo_justifications.empty?
end

def publishing_in_channel
end

def get_complaint_by_button
    complaint_id = $mes.data.split("/").first
    complaint = Complaint.find_by(id:complaint_id)
end

def update_black_list_user_whith_scamer_status complaint
    user = BlackListUser.find_by(telegram_id:complaint.telegram_id)
    user.update(is_self_scamer:true)
end

def handle_accept_complaint
    complaint = get_complaint_by_button()
    return if complaint.nil?
    is_already_handled = complaint.status != "to_moderator"
    if is_already_handled
        Send.mes(Text.was_handled)
    else
        complaint.update(status:'accepted_complaint')
        publishing_in_channel
        update_black_list_user_whith_scamer_status(complaint)
        Send.mes(Text.handle_accept_complaint)
        black_list_bot = Telegram::Bot::Client.new(TOKEN_BOT)
        black_list_bot.api.send_message(
            text:Text.complaint_published(complaint),
            chat_id:complaint.black_list_user.telegram_id
        )
    end
end

def handle_reject_complaint
    complaint = get_complaint_by_button()
    return if complaint.nil?
    is_already_handled = complaint.status != "to_moderator"
    if is_already_handled
        Send.mes(Text.was_handled)
    else
        $user.update(cur_complaint_id:complaint.id)
        Send.mes(Text.input_cause_of_reject)
    end
end

def get_scamer_by_button
    scamer_id = $mes.data.split("/").first
    scamer = BlackListUser.find(user_id)
end

def send_notify_to user, text
    main_bot = Telegram::Bot::Client.new(TOKEN_BOT)
    main_bot.api.send_message(
        chat_id:user.telegram_id,
        text:text
    )
end

def accessing_justification
    scamer = get_scamer_by_button()
    return if scamer.is_self_scamer == false # уже обработан
    
    accessed_complaints = Complaint.where(telegram_id:scamer.telegram_id).where(status:'accepted_complaint')
    accessed_complaints.update_all(status:"rejected_complaint")

    scamer.update!(
        is_self_scamer:false,
        state_aasm:'start',
        justification:nil
    )

    clear_user = scamer
    Send.mes(Text.accessing_justification)
    send_notify_to(clear_user, Text.you_not_scamer)


end
def blocking_scamer
    scamer = get_scamer_by_button()
    return if scamer.is_self_scamer == false # уже обработан

    scamer.update!(is_blocked_by_moderator:true)

    Send.mes(Text.blocking_user)
    send_notify_to(scamer, Text.you_blocked)

end