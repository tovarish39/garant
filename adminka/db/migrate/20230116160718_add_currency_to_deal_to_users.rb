class AddCurrencyToDealToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :currency_to_deal, :string
  end
end
