class Dispute < ApplicationRecord
  belongs_to :deal
  has_one :bound_moderator
end
