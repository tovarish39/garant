class AddToModerator < ActiveRecord::Migration[7.0]
  def change
    add_column :moderators, :first_name, :string
    add_column :moderators, :last_name, :string
  end
end
