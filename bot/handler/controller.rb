def handle
    
    $user = searching_user()              # поиск ранее созданного user
    $user ||= create_user() unless $user  # создание user, если не найден
    $lang = $user.lang
    update_username_if_changed()

    $next_mes_id = next_mes_id()

    if    $mes.class == Message
        case 
        when $lang == 'viewed' ;delete_text()    # сообщение о языке было предложено
        when !$lang            ;view_languages()  # обязательный выбор языка
        
        when $user.filling['pending'] == 'stop-text'; delete_text()
        when $user.filling['pending'] == 'pending amount'; handle_amount()
        when $user.filling['pending'] == 'pending conditions'; handle_condition()
        
        when $user.filling['pending'] == "to_user_id";search_user_for_deal()     # данные для поиска user в бд для сделки
        when $mes.text == Find_user[$lang];           pending_user()                # получено "найти пользователя"

        else start()
        end

    elsif $mes.class == Callback

        case
        when $mes.data =~ /Выбранный язык/;language_selected()
        when $mes.data == 'Cancel';           cancel()
        when $user.lang
            
            
            income_mes_id = $mes.data.split('/').last
            puts "income_mes_id  = #{income_mes_id}"
            puts $user.next_mes_id
            return if income_mes_id != $user.next_mes_id 
            $user.update(next_mes_id:$next_mes_id)


            income_data = $mes.data.split('/')
            $to_user_id_data = income_data[1]
            $role_data       = income_data[2]
            $currency_data   = income_data[3]
            $amount_data     = income_data[4]
            $conditions_data = income_data[5]
            
            $to_user_id = $user.filling['to_user_id']

            return unless $to_user_id_data

            case
            when $mes.data =~ /Назад к юзеру/;    search_user_for_deal()
            when $mes.data =~ /Споры/;            disputs()
            when $mes.data =~ /Отзывы/;           comments()
            when $mes.data =~ /Предложить сделку/;new_deal()
            when $mes.data =~ /Выйграл споров/;   wins()
            when $mes.data =~ /Проиграл споров/;  losts()
            when $mes.data =~ /Назад к спорам/;   disputs()
            
            when $mes.data =~ /Купить/;           currency_types()
            when $mes.data =~ /Продать/;          currency_types()
            
            when $mes.data =~ /Назад к действиям/;search_user_for_deal()
            when $mes.data =~ /Другое/;                         
            when $mes.data =~ /Криптовалюта/;       crypto_currencies()
            when $mes.data =~ /Назад к типам валют/;currency_types()
            when $mes.data =~ /Валюта сделки/;      currency_to_amount()
            when $mes.data =~ /Подтвердить сделку/;      create_deal()
            end
        end
    end 

end

def next_mes_id length = 4
    down_case = ('a'..'z').to_a
    up_case =   ('A'..'Z').to_a
    digits =    ('0'..'9').to_a
    characters = down_case + up_case + digits
    size = characters.size
    path = ''
    length.times {path += characters[rand(size)]}
    path
end

def send_message text, reply_markup = nil
    $bot.send_message(
        chat_id: ($mes.class == Callback) ? $mes.message.chat.id : $mes.chat.id, 
        text:text, 
        reply_markup:reply_markup, 
        parse_mode: (text.include?('<')) ? "HTML" : nil
    )
end

def delete_pushed
    $bot.delete_message(
        chat_id:$mes.message.chat.id, 
        message_id:$mes.message.message_id
    )
end

def delete_text
    $bot.delete_message(
        chat_id:$mes.chat.id, 
        message_id:$mes.message_id
    )
end

def edit_message text, reply_markup = nil
    $bot.edit_message_text(
        chat_id: $mes.message.chat.id, 
        message_id:$mes.message.message_id, 
        text:text, 
        reply_markup:reply_markup, 
        parse_mode: (text.include?('<')) ? "HTML" : nil
    )
end