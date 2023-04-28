# frozen_string_literal: true

require 'telegram/bot'
require 'json'
require 'active_record'
require 'redis'
require 'logger'

logger = Logger.new('logs_kassa.log')
logger.formatter = proc do |severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{severity.slice(0)}-[#{date_format}] pid=##{Process.pid} mes='#{msg}'\n"
end

redis = Redis.new

token = ENV['Counter_invited_sites_bot_token']

Chat_id_my = '1964112204'
Ru = 'Русский'
En = 'English'

#
# redis listen
#
begin
  redis.subscribe(:one, :two) do |on|
    on.message do |_channel, message|
      puts message
    end
  end
rescue Redis::BaseConnectionError => e
  logger.error("#{e}, retrying in 1s")
  sleep 1
  retry
end

#
# bot listener
#
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bot.api.send_message(text: message.text, chat_id: message.chat.id)
  end
end
