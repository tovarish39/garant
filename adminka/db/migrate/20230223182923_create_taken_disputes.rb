class CreateTakenDisputes < ActiveRecord::Migration[7.0]
  def change
    create_table :taken_disputes do |t|
      t.references :moderator, null: false, foreign_key: true
      t.references :dispute, null: false, foreign_key: true

      t.timestamps
    end
  end
end
