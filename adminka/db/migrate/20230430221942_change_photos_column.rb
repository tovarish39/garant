class ChangePhotosColumn < ActiveRecord::Migration[7.0]
  def change
    # remove_column :scamers, :photos_dir_path, :string
    add_column :scamers, :photo_ulrs_remote_tmp, :string, array:true, default:[]
  end
end
