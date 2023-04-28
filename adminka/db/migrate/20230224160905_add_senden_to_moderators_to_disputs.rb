# frozen_string_literal: true

class AddSendenToModeratorsToDisputs < ActiveRecord::Migration[7.0]
  def change
    add_column :disputes, :sended_to_moderators, :string, array: true, default: []
  end
end
