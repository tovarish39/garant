class RenameCurScamerIdToCurComplaintIdToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :black_list_users, :cur_scamer_id, :cur_complaint_id
  end
end
