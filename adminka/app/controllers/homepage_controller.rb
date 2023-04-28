# frozen_string_literal: true

class HomepageController < ApplicationController
  def index; end

  def users
    users = User.all
    users_with_deals_size = []

    users.map do |user|
      user_string = user.to_json
      user_json   = JSON.parse(user_string)
      user_json[:deals_size] = get_all_deals_size(user)
      users_with_deals_size.push(user_json)
    end

    render json: users_with_deals_size
  end

  def send_message_to_users
    require 'telegram/bot'

    token_main = ENV['Garant_bot_token']

    ids = params['user_ids'] # .split(',')
    message = params['message']

    Telegram::Bot::Client.run(token_main) do |bot|
      ids.each do |id|
        user = User.find(id)

        bot.api.send_message(text: message, chat_id: user.telegram_id)
      end
    end

    head :ok
  end

  private

  def get_all_deals_size(user)
    Deal.where("seller_id = #{user.id} or custumer_id = #{user.id}").size
  end
end
