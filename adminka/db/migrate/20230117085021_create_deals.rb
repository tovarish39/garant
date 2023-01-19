class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.integer :seller_user_id
      t.integer :order_user_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
