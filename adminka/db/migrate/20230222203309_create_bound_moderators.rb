class CreateBoundModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :bound_moderators do |t|
      t.references :dispute, null: false, foreign_key: true
      t.string :telegram_id
      t.string :username

      t.timestamps
    end
  end
end
