class Scamer < ApplicationRecord
  belongs_to :black_list_user

  validates :status, inclusion: {in: %w[
    filling
    request_by_user
    uploaded_on_tmp
    accepted_by_moderator
    rejected_by_moderator
    ]}
end
