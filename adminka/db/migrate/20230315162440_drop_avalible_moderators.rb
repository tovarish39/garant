# frozen_string_literal: true

class DropAvalibleModerators < ActiveRecord::Migration[7.0]
  def change
    drop_table :avalible_moderators
  end
end
