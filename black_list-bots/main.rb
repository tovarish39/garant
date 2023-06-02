# frozen_string_literal: true

require_relative 'requires'

pid_file_path = "#{ROOT_BOT}/tmp/main.pid"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }

$logger = Logger.new("#{ROOT_BOT}/log/black-list-bot.log", 'weekly')
$logger.formatter = proc do |severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end

Telegram::Bot::Client.run(TOKEN_BOT) do |bot|
  bot.listen do |message|
    $mes = message
    $bot = bot

    # bot.api.send_message(text:$mes.inspect, chat_id:MY_CHAT_ID)
    
      
    begin
      handle if $mes.from.present?
    rescue StandardError => e
      Send.mes(e, to:MY_CHAT_ID)
      Send.mes(e.backtrace, to:MY_CHAT_ID)
    end
  end
end

