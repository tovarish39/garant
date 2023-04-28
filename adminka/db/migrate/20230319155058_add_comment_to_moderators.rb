# frozen_string_literal: true

class AddCommentToModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :moderators, :comment, :string
  end
end
