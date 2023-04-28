class CreateBlackListUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :black_list_users do |t|
      t.string :telegram_id
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :lang
      t.string :state_aasm
      t.string :cur_scamer_id

      t.timestamps
    end
  end
end
