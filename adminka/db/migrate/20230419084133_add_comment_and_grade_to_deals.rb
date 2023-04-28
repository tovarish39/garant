# frozen_string_literal: true

class AddCommentAndGradeToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :comment, :string
    add_column :deals, :grade,   :string
  end
end
