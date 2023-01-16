class AddNewUserIdToDealToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :new_user_id_to_deal, :string
  end
end
