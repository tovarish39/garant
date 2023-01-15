def handle
    # $bot.send_message(chat_id:$mes.chat.id, text:'text')
    $user = searching_user()              # поиск ранее созданного user
    $user ||= create_user() unless $user  # создание user, если не найден
    $lang = $user.lang
    update_username_if_changed()

    # $bot.send_message(chat_id:$mes.chat.id, text:'text')
 
    if    $mes.class == Message   
        case 
        when $user.new_trans == "true"        ; search_user_for_trans() # данные для поиска user в бд для сделки
        when $mes.text == Propose_dial[$lang]; new_trans()             # получено "Предложить сделку"
        else start()
        end
    elsif $mes.class == Callback
        case
        when $mes.data =~ /Предложить сделку/; choose_role()
        end
    end 

end


# def handle
#     $user = searching_user()              # поиск ранее созданного user
#     user_new = true unless $user  
#     $user ||= create_user() unless $user  # создание user, если не найден
#     $lang = $user.language
#     update_username_if_changed()
#     check_subscription_time_end() if $user.subscription != 'no'

#     return if $user.locked

#     if    $message.class == Message   
#         user_new_has_referer = $message.text.include?('/start') && $message.text.include?(' ') && user_new # если открыта ссылка от referer и пользователь новый

#         case
#         when !$lang ;                             choose_language(user_new_has_referer) # обязательный выбор языка # если открыта ссылка от referer и пользователь новый
#         when $message.text == Cancel[$lang];      link_name_new_cancel()           # отмена создания :link_name_new
#         when link_name_new?();                    link_origin_new_after_validate() # создание :link_name_new, валидация, если ок, создания :link_origin_new
#         when $message.text == Back[$lang];        link_origin_new_back()           # отмена coздания :link_original_new, coзданиe :link_name_new
#         when link_origin_new?();                  link_complete()                  # создание Route и Link           
#         when $message.text == Link_create[$lang]; link_name_new()                  # создания :link_name_new
#         when $message.text == Links[$lang];       links()                          # "мои ссылки"
#         when $message.text == Profile[$lang];     show_profile()                   # профиль
#         else                                      main_menu()                      # основное меню
#         end 

#     elsif $message.class == Callback
#         case
#         when $message.data == Change_lang_data;    choose_language()
#         when $message.data =~ /Русский/;           selected_language()
#         when $message.data =~ /English/;           selected_language()
#         when $message.data =~ /details/;           link_details()
#         when $message.data =~ /delete/;            link_delete()
#         when $message.data =~ /download_all/;      upload_all()
#         when $message.data =~ /download_uniq/;     upload_uniq()
#         when $message.data =~ /back/;              back_inline()
#         when $message.data == 'Реферальная ссылка';get_ref_link()
#         when $message.data == 'Оформить подписку'; subscribe()
#         when $message.data == 'Trial';             trial()
#         end
#     end
# end