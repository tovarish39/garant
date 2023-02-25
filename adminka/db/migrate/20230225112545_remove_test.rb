class RemoveTest < ActiveRecord::Migration[7.0]
  def change
    remove_column :avalible_moderators, :test
  end
end
