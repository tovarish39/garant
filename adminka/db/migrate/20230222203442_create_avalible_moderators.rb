# frozen_string_literal: true

class CreateAvalibleModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :avalible_moderators, &:timestamps
  end
end
