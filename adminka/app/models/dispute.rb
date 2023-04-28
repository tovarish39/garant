# frozen_string_literal: true

class Dispute < ApplicationRecord
  belongs_to :deal

  has_one :taken_dispute, dependent: :destroy
  has_one :moderator, through: :taken_dispute
end
