class BlackListUser < ApplicationRecord
    has_many :scamers

    validates :status, inclusion: {in: %{
        'Проверенный'
    }}
end
