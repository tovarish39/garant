class RenameCurrencyToDealToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :currency_to_deal, :new_currency_to_deal
  end
end
