# frozen_string_literal: true

class Garant::UsersController < ApplicationController
  
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

    bot =Telegram::Bot::Client.new(token_main)
    ids.each do |id|
      user = User.find(id)
      bot.api.send_message(text: message, chat_id: user.telegram_id)
    end

    head :ok
  end

  def statistic
      active_ru_users = 0
      active_en_users = 0
    inactive_ru_users = 0
    inactive_en_users = 0
    closed_disputes   = 0
    opened_disputes   = 0
    User.all.each do |user|
      case 
      when user.lang == 'Русский' && user.with_bot_status == 'member'
        active_ru_users += 1
      when user.lang == 'Русский' && user.with_bot_status == 'kicked'
        inactive_ru_users += 1
      when user.lang == 'English' && user.with_bot_status == 'member'
        active_en_users += 1
      when user.lang == 'English' && user.with_bot_status == 'kicked'
        inactive_en_users += 1
      end
    end
    # debugger
    Dispute.all.each do |dispute|
      if dispute.status =~ /finished/          # рассмотренные
        closed_disputes +=1  
      elsif dispute.status =~ /pending_moderator/ # не распределённые
        opened_disputes +=1 
      end
    end

    statistic = {
      active_ru_users:active_ru_users,
      active_en_users:active_en_users,
      inactive_ru_users:inactive_ru_users,
      inactive_en_users:inactive_en_users,
      closed_disputes:closed_disputes,
      opened_disputes:opened_disputes
    }

    render json: statistic
  end

  private


  def get_all_deals_size(user)
    Deal.where("seller_id = #{user.id} or custumer_id = #{user.id}").size
  end
end
