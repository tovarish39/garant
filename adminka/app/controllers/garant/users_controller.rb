# frozen_string_literal: true

class Garant::UsersController < ApplicationController
  
  def index; end

  def test

    debugger

    
  end

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
    opened_disputes   = 0
    closed_disputes   = 0
    closed_disputes_by_day   = 0
    closed_disputes_by_week   = 0
    closed_disputes_by_month   = 0
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
        closed_disputes_by_day   +=1 if check_by_day(dispute)
        closed_disputes_by_week  +=1 if check_by_week(dispute)
        closed_disputes_by_month +=1 if check_by_month(dispute)
      elsif dispute.status =~ /pending_moderator/ # не распределённые
        opened_disputes +=1 
      end
    end

    statistic = {
      active_ru_users:active_ru_users,
      active_en_users:active_en_users,
      inactive_ru_users:inactive_ru_users,
      inactive_en_users:inactive_en_users,
      opened_disputes:opened_disputes,
      closed_disputes_by_day:closed_disputes_by_day,
      closed_disputes_by_week:closed_disputes_by_week,
      closed_disputes_by_month:closed_disputes_by_month,
    }

    render json: statistic
  end

  private
  def check_by_day dispute
    (dispute.updated_at + 1.day) > Time.now
  end

  def check_by_week dispute
    (dispute.updated_at + 1.week) > Time.now
  end

  def check_by_month dispute
    (dispute.updated_at + 1.day) > Time.now
  end

  def get_all_deals_size(user)
    Deal.where("seller_id = #{user.id} or custumer_id = #{user.id}").size
  end
end
