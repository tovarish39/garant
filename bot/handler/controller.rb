def handle
    $user = searching_user()              # поиск ранее созданного user
    $user ||= create_user() unless $user  # создание user, если не найден
    $lang = $user.lang
    update_username_if_changed()
 
    if    $mes.class == Message   
        case 
        when !$lang ;                       language_choose()       # обязательный выбор языка # если открыта ссылка от referer и пользователь новый
        when $user.new_deal == "true";      search_user_for_deal() # данные для поиска user в бд для сделки
        when $mes.text == Find_user[$lang]; find_user()             # получено "найти пользователя"
        when !$user.currency_to_deal;       try_write_amount_currency()
        else start()
        end
    elsif $mes.class == Callback
        case
        when $mes.data == 'Cancel';                         cancel()
        when $mes.data =~ /Выбранный язык/;                 language_selected()
        when $mes.data =~ /Предложить сделку/;              new_deal()
        when $mes.data =~ /Отзывы/;                         comments()
        when $mes.data =~ /Споры/;                          disputs()
        when $mes.data =~ /Назад к выбранному ранее юзеру/; finding_earlier_user()
        when $mes.data =~ /Выйграл споров/;                 wins()
        when $mes.data =~ /Проиграл споров/;                losts()
        when $mes.data =~ /Назад к спорам/;                 disputs()
        when $mes.data =~ /Купить/;                         currency_types()
        when $mes.data =~ /Продать/;                        currency_types()
        when $mes.data =~ /Криптовалюта/;                   crypto_currencies()
        when $mes.data =~ /Другое/;                         
        when $mes.data =~ /Назад к действиям/;              finding_earlier_user()
        when $mes.data =~ /Назад к типам валют/;            currency_types()
        when $mes.data =~ /Валюта сделки/;                  currency_to_amount()
        end
    end 

end