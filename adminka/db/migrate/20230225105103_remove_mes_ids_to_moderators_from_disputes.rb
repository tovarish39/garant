# frozen_string_literal: true

class RemoveMesIdsToModeratorsFromDisputes < ActiveRecord::Migration[7.0]
  def change
    remove_column :disputes, :mes_ids_to_moderators
  end
end
