# frozen_string_literal: true

class TakenDispute < ApplicationRecord
  belongs_to :moderator
  belongs_to :dispute
end
