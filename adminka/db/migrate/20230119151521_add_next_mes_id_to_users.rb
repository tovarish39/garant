class AddNextMesIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :next_mes_id, :string
  end
end
