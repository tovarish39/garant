class AddNewTransToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :new_trans, :string, default: 'false'
  end
end
