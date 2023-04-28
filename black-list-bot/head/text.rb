module Text
    def self.lang   = 'выберите язык'

    def self.greet 
        'Текст приветствия к котопрому прикрекплекно видео'
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
    def self.less_then_min_photos_size
        "Необходимо отправить хотя бы одно фото"
    end
    def self.handle_photo
        "Изображение №#{$user.photos_size} успешно принято, вы можете отправить еще или продолжить подачу жалобы нажав кнопку “Готово”"
    end
end