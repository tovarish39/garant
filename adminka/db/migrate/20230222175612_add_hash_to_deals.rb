class AddHashToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :hash, :string
  end
end
