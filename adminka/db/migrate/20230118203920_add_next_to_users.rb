class AddNextToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :next, :string
  end
end
