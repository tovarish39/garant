class AddIsSelfScamerToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_users, :is_self_scamer, :boolean, default: false
  end
end
