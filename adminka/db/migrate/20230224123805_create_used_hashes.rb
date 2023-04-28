# frozen_string_literal: true

class CreateUsedHashes < ActiveRecord::Migration[7.0]
  def change
    create_table :used_hashes do |t|
      t.string :name

      t.timestamps
    end
  end
end
