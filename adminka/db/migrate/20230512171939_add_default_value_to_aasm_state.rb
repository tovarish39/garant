class AddDefaultValueToAasmState < ActiveRecord::Migration[7.0]
  def change
    change_column_default :moderators, :aasm_state, 'deals_menu'
  end
end
