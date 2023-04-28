# frozen_string_literal: true

class CreateDisputes < ActiveRecord::Migration[7.0]
  def change
    create_table :disputes do |t|
      t.references :deal, null: false, foreign_key: true
      t.string :created_by_user_id
      t.string :status
      t.string :mes_ids_to_moderators, array: true, default: []
      t.text   :content

      t.timestamps
    end
  end
end
