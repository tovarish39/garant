# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :telegram_id
      t.string :lang

      t.string :state, default: 'start'
      t.string :to_user_id
      t.string :role
      t.string :currency
      t.string :amount
      t.text   :conditions

      t.timestamps
    end
  end
end
