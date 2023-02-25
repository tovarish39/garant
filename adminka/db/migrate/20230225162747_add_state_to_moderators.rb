class AddStateToModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :moderators, :state, :string
  end
end
