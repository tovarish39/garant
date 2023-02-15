class ChangeColumnNamesDeals < ActiveRecord::Migration[7.0]
  def change
    rename_column :deals, :seller_user_id,   :seller_id
    rename_column :deals, :custumer_user_id, :custumer_id
  end
end
