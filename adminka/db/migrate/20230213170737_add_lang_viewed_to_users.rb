class AddLangViewedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lang_viewed, :boolean
  end
end
