class AddJustificationToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_users, :justification, :text
  end
end
