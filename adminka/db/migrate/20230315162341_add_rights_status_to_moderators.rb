# frozen_string_literal: true

class AddRightsStatusToModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :moderators, :rights_status, :string, default: 'inactive'
  end
end
