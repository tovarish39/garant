# frozen_string_literal: true

class AddWalletToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :wallet, :json, default: {}
  end
end
