# frozen_string_literal: true

class User < ApplicationRecord
  has_many :deals#, dependent: :destroy
end
