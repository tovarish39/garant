class RenameOrderUserIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :deals, :order_user_id, :custumer_user_id
  end
end
