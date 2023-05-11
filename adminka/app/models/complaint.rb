class Complaint < ApplicationRecord
  belongs_to :black_list_user

  validates :status, inclusion: {in: %w[
    filling
    to_moderator
    accepted_complaint
    rejected_complaint
    ]}


  scope :with_statuses,  ->(statuses){ where(status:statuses)}
end
