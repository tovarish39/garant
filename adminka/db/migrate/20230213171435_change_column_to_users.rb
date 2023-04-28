# frozen_string_literal: true

class ChangeColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :to_user_id, :userTo_id
  end
end
