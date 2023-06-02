class AddMesIdPublishedInChannelToComplaints < ActiveRecord::Migration[7.0]
  def change
    add_column :complaints, :mes_id_published_in_channel, :string
  end
end
