def justification_request_to_moderator
    accepted_complaints = Complaint.where(telegram_id:$user.telegram_id).filter {|complaint| complaint.status == 'accepted_complaint'}

    moderator_bot = Telegram::Bot::Client.new(TOKEN_BOT_MODERATOR)
    moderators = BlackListModerator.all
    moderators.each do |moderator|
        scamer = $user
        moderator_bot.api.send_message(
            chat_id:moderator.telegram_id,
            text:Text.justification_request_to_moderator(accepted_complaints, scamer),
            reply_markup:M::Inline.justification_request_to_moderator($user),
            parse_mode:"HTML"
        )
    rescue
    end
end


def text_justification
    justification = $mes.text
    $user.update!(justification:justification)

    Send.mes(Text.justification_already_used)
    justification_request_to_moderator
end