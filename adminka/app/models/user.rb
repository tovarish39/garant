class User < ApplicationRecord
    has_many :deals, dependent: :destroy
    has_one :wallet, dependent: :destroy
end
