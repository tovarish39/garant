# frozen_string_literal: true

class CreateModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :moderators do |t|
      t.string :telegram_id
      t.string :username

      t.timestamps
    end
  end
end
