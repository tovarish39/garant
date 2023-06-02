class AddCurMesIdToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_users, :cur_mes_id, :string
  end
end
