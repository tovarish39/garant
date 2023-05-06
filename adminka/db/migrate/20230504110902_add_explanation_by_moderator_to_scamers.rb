class AddExplanationByModeratorToScamers < ActiveRecord::Migration[7.0]
  def change
    add_column :scamers, :explanation_by_moderator, :text
  end
end
