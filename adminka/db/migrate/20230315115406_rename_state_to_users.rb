class RenameStateToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :state, :aasm_state
  end
end
