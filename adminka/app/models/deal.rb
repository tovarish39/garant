# frozen_string_literal: true

class Deal < ApplicationRecord
  belongs_to :user
  has_many   :disputes, dependent: :destroy
end
