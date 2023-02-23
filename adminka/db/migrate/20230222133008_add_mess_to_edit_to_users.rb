class AddMessToEditToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mes_ids_to_edit, :string, array: true, default: []
  end
end
