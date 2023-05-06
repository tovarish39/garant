class AddTelegraphLinkToScamers < ActiveRecord::Migration[7.0]
  def change
    add_column :scamers, :telegraph_link, :string
  end
end
