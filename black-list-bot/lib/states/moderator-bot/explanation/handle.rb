def handle_explanation
    scamer = Scamer.find($user.cur_scamer_id)
    explanation_text = $mes.text
    
    scamer.update!(
        explanation_by_moderator:explanation_text,
        status:'rejected_complaint'
    )
    Send.mes(Text.handle_explanation(scamer))
    black_list_bot = Telegram::Bot::Client.new(TOKEN_BOT)
    black_list_bot.api.send_message(
        text:Text.handle_explanation(scamer),
        chat_id:scamer.black_list_user.telegram_id
    )
end