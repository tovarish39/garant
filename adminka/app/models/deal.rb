# frozen_string_literal: true

class Deal < ApplicationRecord
  belongs_to :user
  has_many   :disputes, dependent: :destroy

  scope :where_user_is_seller,  -> (user){     where(seller_id:user.telegram_id)}
  scope :with_comment        ,  ->       { where.not(comment:  nil           )}
end
