class AddLangToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lang, :string, default: 'Russian'
  end
end
