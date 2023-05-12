module Text
    def self.lang   = 'выберите язык'
    def self.greet 
        'Текст приветствия к котопрому прикрекплекно видео'
    end
    def self.greeting_mod
        'Приветствие модератору'
    end
    def self.clear_account
       'Вы не находитесь в списке скамеров!' 
    end
    def self.search_user
        'Пришлите нам ID обвиняемогo или выберите чат с ним при помощи кнопки “🔎 Выбрать”'
    end
    def self.not_found
        'Пользователь не найден'
    end
    def self.user_info user
        "User info: \nID: #{user.telegram_id} \n#{"First Name: #{user.first_name}\n" if user.first_name.present?}#{"Username: @#{user.username}\n" if user.username.present?}"
    end
    def self.complaint_text
        "Объясните ситуацию, ввведите сообщение длиной от #{MIN_LENGTH_COMPLAINT_TEXT} до #{MAX_LENGTH_COMPLAINT_TEXT} символов"
    end
    def self.more_then_max_length
        "Вы превысили количество символов, отправьте сообщение длиной до #{MAX_LENGTH_COMPLAINT_TEXT} символов"
    end
    def self.less_then_min_length
        "вы ввели недостаточно символов отправьте сообщение длиной от #{MIN_LENGTH_COMPLAINT_TEXT} символов"
    end
    def self.complaint_photos
        'Отправьте скриншоты диалога на которых виден процесс обмана, порсле отправки нажмите кнопку “Готово”'
    end
    def self.notice_max_photos_size
        "Максимальное количество фотографий #{MAX_PHOTOS_SIZE}"
    end
    def self.notice_min_photos_size
        'Необходимо отправить фото'
    end
    def self.less_then_min_photos_size
        "Необходимо отправить хотя бы одно фото"
    end
    def self.handle_photo photos_size
        "Изображение №#{photos_size} успешно принято, вы можете отправить еще или продолжить подачу жалобы нажав кнопку “Готово”"
    end
    def self.compare_user_id
        'Перешлите сообщения ответчика из чата, соответствующие скрину'
    end
    def self.complaint_request_to_moderator scamer
        "Ваша жалоба #N#{scamer.id} была отправлена на проверку модератором, ожидайте её рассмотрения о результатах вас оповестит бот"
    end
    def self.moderator_complaint user, scamer
        %{\n
<strong>Жалоба</strong> #N#{scamer.id}

<strong>ОТ</strong>
#{Text.user_info(user)}\n
<strong>На</strong>
#{Text.user_info(scamer)}
<strong>Ссылка</strong> <a href='#{scamer.telegraph_link}'>telegraph_link</a>
}
    end
    def self.was_handled
        'Был ранее обработан'
    end
    def self.handle_accept_complaint
        'Обработано. ссылка на пост на канале'
    end
    def self.complaint_published scamer
        "Ваша жалоба #N#{scamer.id} Опубликована. Ссылка на пост"
    end
    def self.input_cause_of_reject
        'ВВедите причину отклонения'
    end
    def self.handle_explanation scamer
        "Жалоба #N#{scamer.id}\n❌Отклонена❌\n<b>Причина: </b>\n#{scamer.explanation_by_moderator}"
    end
    def self.view_complaints telegraph_links
        text_body = telegraph_links.map {|link| "\nСсылка:<a href='#{link}'>telegraph_link</a>"}
        return "Вы обнаружены в списке скамеров!" + text_body.join('')
    end
    def self.explain_justification
        "Опишите вашу версию событий"
    end
    def self.justification_already_used
        "Вы обнаружены в списке скамеров!\nВаше заявление на рассмотрении"
    end
    def self.justification_request_to_moderator accepted_complaints, scamer
        text_body = accepted_complaints.map {|complaint| "\n<strong>Жалоба</strong> #N#{complaint.id}\n<strong>Ссылка</strong> <a href='#{complaint.telegraph_link}'>telegraph_link</a>\n<strong>Ссылка</strong> пост\n\n <b>Объяснение:</b> #{scamer.justification} "}
        return "⚖️Оспорить решение⚖️\n" + text_body.join('')
    end
    def self.accessing_justification
        "Обработано"
    end
    def self.you_not_scamer
        'Ура, вы не скамер'
    end
    def self.blocking_user
        "Юзер заблокирован"
    end
    def self.you_blocked
        "Вы заблокированы"
    end
    def self.not_complaints
        "Заявки ни зарегистрированы"
    end
    def self.complaint scamer
        "Жалоба #N#{scamer.id}"
    end
end