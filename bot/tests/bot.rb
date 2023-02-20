require 'telegram/bot'



token = ENV['BOT_TOKEN']
my_telegram_id   = 1964112204
seva_telegram_id = 6016837864

request_id = 111
UserShared = {request_id:request_id}

KeyboardButtonRequestUser = {request_id:request_id}
KeyboardButton = {text:'textttt', request_user:KeyboardButtonRequestUser}
Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        # puts message.user_shared if !message.text
        # puts message.from.id
    #   mes =  bot.api.send_message(text:message.text, chat_id:message.chat.id)
    #   bot.api.edit_message_text(message_id:7820 ,text:message.text, chat_id:message.chat.id)


        answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
            .new(keyboard: [[KeyboardButton]], one_time_keyboard: true)
        #  bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)


        mes = bot.api.send_message(
            asd:'asd',
            chat_id:message.chat.id,
            text:message.text,
            reply_markup: answers
        ) if message.text

        puts mes if message.text
    end
end






# uri = URI("https://api.telegram.org/bot#{token}/sendMessage")
# body = {
#     chat_id:'1964112204',
#     text:'mes text',
#     reply_markup: {
#         keyboard: 
#             [
#                 [KeyboardButton]
#             ]
        
#     }               
# }

# headers = { 'Content-Type': 'application/json' }
# response = Net::HTTP.post(uri, body.to_json, headers)
# puts response.body