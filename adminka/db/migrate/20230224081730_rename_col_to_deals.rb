# frozen_string_literal: true

class RenameColToDeals < ActiveRecord::Migration[7.0]
  def change
    rename_column :deals, :hash, :hash_name
  end
end
