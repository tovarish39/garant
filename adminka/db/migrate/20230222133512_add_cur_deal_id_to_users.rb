# frozen_string_literal: true

class AddCurDealIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cur_deal_id, :string
  end
end
