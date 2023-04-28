# frozen_string_literal: true

class ChangeColumnToDisputes < ActiveRecord::Migration[7.0]
  def change
    remove_column :disputes, :sended_to_moderators
    add_column :disputes, :sended_to_moderators, :json, array: true, default: []
  end
end
