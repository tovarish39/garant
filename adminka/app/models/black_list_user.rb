class BlackListUser < ApplicationRecord
    has_many :complaints

    validates :status_by_moderator, inclusion: {in: [
        'Проверенный',
        'Не проверенный',
        nil
    ]
    }
end
