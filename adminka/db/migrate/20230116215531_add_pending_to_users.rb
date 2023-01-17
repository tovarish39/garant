class AddPendingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pending, :string
  end
end
