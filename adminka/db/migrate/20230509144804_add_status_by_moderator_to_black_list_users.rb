class AddStatusByModeratorToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_users, :status_by_moderator, :string
  end
end
