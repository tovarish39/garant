class ChangeRightStatusToModerators < ActiveRecord::Migration[7.0]
  def change
    change_column_default :moderators, :rights_status, from:'inactive', to:nil
  end
end
