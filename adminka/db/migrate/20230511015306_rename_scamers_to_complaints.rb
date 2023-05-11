class RenameScamersToComplaints < ActiveRecord::Migration[7.0]
  def change
    rename_table :scamers, :complaints
  end
end
