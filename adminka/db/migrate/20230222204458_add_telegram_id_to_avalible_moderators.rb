class AddTelegramIdToAvalibleModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :avalible_moderators, :telegram_id, :string
  end
end
