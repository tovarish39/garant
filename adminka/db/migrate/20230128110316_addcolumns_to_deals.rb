class AddcolumnsToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :currency,   :string
    add_column :deals, :amount,     :string
    add_column :deals, :state,      :string
    add_column :deals, :conditions, :text
  end
end
