class Scamer < ApplicationRecord
  belongs_to :black_list_user

  validates :status, inclusion: {in: %w[
    filling
    request
    accepted
    rejected
    ]}
end
