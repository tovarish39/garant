class Dispute < ApplicationRecord
  belongs_to :deal

  has_one :taken_dispute
  has_one :moderator, through: :taken_dispute
end
