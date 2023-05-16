# frozen_string_literal: true

class Dispute < ApplicationRecord
  belongs_to :deal

  validates :dispute_lost, inclusion: {in: [
    nil,
    'seller_lost',
    'custumer_lost',
    'all_lost'
  ]}

  has_one :taken_dispute, dependent: :destroy
  has_one :moderator, through: :taken_dispute
end
