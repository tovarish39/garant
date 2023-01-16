class AddNewAmountCurrencyToDealToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :new_amount_currency_to_deal, :string
  end
end
