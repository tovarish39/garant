class RenameStateFromModerators < ActiveRecord::Migration[7.0]
  def change
    rename_column :moderators, :state, :aasm_state
  end
end
