class AddToDisputes < ActiveRecord::Migration[7.0]
  def change
    add_column :disputes, :comment_by_moderator, :text
    add_column :disputes, :dispute_lost, :string

  end
end
