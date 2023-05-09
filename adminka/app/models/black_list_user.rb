class BlackListUser < ApplicationRecord
    has_many :scamers

    validates :status_by_moderator, inclusion: {in: [
        'Проверенный',
        'Не проверенный',
        nil
    ]
    }
end
