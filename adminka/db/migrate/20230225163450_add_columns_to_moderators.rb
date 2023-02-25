class AddColumnsToModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :moderators, :pushed_IB_mes_id,   :string
    add_column :moderators, :current_dispute_id, :string
    add_column :moderators, :pushed_action,      :string
  end
end
