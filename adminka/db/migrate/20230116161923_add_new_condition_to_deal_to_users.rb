class AddNewConditionToDealToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :new_condition_to_deal, :string
  end
end
