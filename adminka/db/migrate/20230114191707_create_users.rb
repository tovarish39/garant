class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :telegram_id
      t.string :lang
      t.json   :filling

      t.timestamps
    end
  end
end
