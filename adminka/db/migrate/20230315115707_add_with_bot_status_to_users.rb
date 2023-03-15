class AddWithBotStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :with_bot_status, :string, default: 'member'
  end
end
