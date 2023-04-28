class CreateScamers < ActiveRecord::Migration[7.0]
  def change
    create_table :scamers do |t|
      t.references :black_list_user, null: false, foreign_key: true
      t.string :telegram_id
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :status
      t.string :photos_dir_path
      t.text :complaint_text

      t.timestamps
    end
  end
end
