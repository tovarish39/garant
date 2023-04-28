class AddPhotosSizeToScamers < ActiveRecord::Migration[7.0]
  def change
    add_column :scamers, :photos_size, :integer, default: 0
  end
end
