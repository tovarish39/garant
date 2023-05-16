# frozen_string_literal: true

class Deal < ApplicationRecord
  belongs_to :user
  has_many   :disputes, dependent: :destroy

  validates :status, inclusion: {in: [
# при создании    
    nil,                   # при создании, когда отправляется запрос другому юзеру
# не оплачено    
    'accessed by_seller',  # seller принял
    'rejected by_seller',  # seller отклонил
    'rejected by_custumer',# customer отклонил
    'payed by_custumer',   # сustomer оплатил
# оплачено
    'canceled by_seller',  
    'finished by_custumer',
# запрос на спор
    'dispute request',     
    'finished by_moderator'# 
    ]}

  scope :as_seller         , -> (user){where(seller_id:user.id)}
  scope :as_customer       , -> (user){where(custumer_id:user.id)}
  scope :as_seller_OR_as_customer, -> (user){where("custumer_id = #{user.id} OR seller_id = #{user.id}")}

  scope :with_comment        ,  ->                  { where.not(comment:  nil           )}
  scope :with_reiting        ,  -> (user)           { where("status = 'finished by_custumer' AND seller_id = #{user.id}") }
  scope :closed_statuses              ,  -> (closed_statuses){ where(status:closed_statuses)}
end
