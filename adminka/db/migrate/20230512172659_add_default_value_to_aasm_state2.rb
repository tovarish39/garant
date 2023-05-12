class AddDefaultValueToAasmState2 < ActiveRecord::Migration[7.0]
  def change
    change_column_default :moderators, :aasm_state, 'moderate'
  end
end
