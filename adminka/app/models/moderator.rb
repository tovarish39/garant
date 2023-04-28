# frozen_string_literal: true

class Moderator < ApplicationRecord
  has_many :taken_disputes
  has_many :disputes, through: :taken_disputes
end
