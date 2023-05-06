class CreateBlackListModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :black_list_moderators do |t|
      t.string :telegram_id
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :state_aasm, default:'moderator'

      t.timestamps
    end
  end
end
