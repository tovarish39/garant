# frozen_string_literal: true

class AddHashNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hash_name, :string
  end
end
