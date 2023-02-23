class CreateAvalibleModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :avalible_moderators do |t|

      t.timestamps
    end
  end
end
