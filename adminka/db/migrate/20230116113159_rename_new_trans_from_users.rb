class RenameNewTransFromUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :new_trans, :new_deal
  end
end
