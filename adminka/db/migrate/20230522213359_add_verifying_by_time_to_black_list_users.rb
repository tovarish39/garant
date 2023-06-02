class AddVerifyingByTimeToBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :black_list_users, :verifying_by_time, :datetime
  end
end
