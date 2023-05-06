class AddCurScamerIdToBlackListModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_moderators, :cur_scamer_id, :string
  end
end
