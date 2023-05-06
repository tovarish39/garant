def justification_request_to_moderator
    # accepted_scamers = $user.scamers.filter {|scamer| scamer.status == 'accepted_complaint' }
    accepted_scamers = Scamer.where(telegram_id:$user.telegram_id).filter {|scamer| scamer.status == 'accepted_complaint'}



    moderator_bot = Telegram::Bot::Client.new(TOKEN_BOT_MODERATOR)
    moderators = BlackListModerator.all
    moderators.each do |moderator|
        moderator_bot.send_message(
            chat_id:moderator.telegram_id,
            text:Text.justification_request_to_moderator(accepted_scamers),
            reply_markup:M::Inline.justification_request_to_moderator($user)
        )
    rescue
    end
end


def text_justification
    justification = $mes.text
    $user.update!(justification:justification)
    # scamer = $user.scamers.find_by(status:'accepted_complaint')
    # scamer.update!(status:'justification')

    Send.mes(Text.justification_already_used)
    justification_request_to_moderator
end