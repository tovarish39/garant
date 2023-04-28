# frozen_string_literal: true

class ChangeColumnNameFromDeal < ActiveRecord::Migration[7.0]
  def change
    rename_column :deals, :state, :status
  end
end
