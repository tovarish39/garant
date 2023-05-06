class AddIsBlockedByModeratorToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_users, :is_blocked_by_moderator, :boolean, default: false
  end
end
