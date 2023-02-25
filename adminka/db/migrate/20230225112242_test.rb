class Test < ActiveRecord::Migration[7.0]
  def change
    add_column :avalible_moderators, :test, :json, array:true, default:[]
  end
end
