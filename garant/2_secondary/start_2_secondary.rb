require_relative  File.expand_path('../../config/requires.rb', __FILE__) #"#{ROOT_GARANT}/config/requires"
require_all      "#{ROOT_GARANT}/2_secondary"

pid_file_path = "#{ROOT_GARANT}/tmp/start_2_secondary.pid"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }


log_path = "#{ROOT_GARANT}/logs/start_2_secondary.log"
$logger = Logger.new(log_path, 'weekly')
$logger.formatter = proc do |severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end


Telegram::Bot::Client.run(Bot_Token_2_SECONDARY) do |bot|
  bot.listen do |message|
    $bot = bot.api
    $mes = message

    begin
      handle
    rescue StandardError => e
      $bot.send_message(text: e, chat_id: CHAT_ID_MY)
      $bot.send_message(text: e.backtrace, chat_id: CHAT_ID_MY)

    end
  end
end
