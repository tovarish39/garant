class ChangeLangToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :lang, :string, default: nil
  end
end
