class User < ApplicationRecord
    has_many :deals, dependent: :destroy
end
