require_relative 'requires'
require_all "#{ROOT}/main"


pid_file_path = "#{ROOT}/tmp/main.pid"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }

log_path = "#{ROOT}/logs/main.log"
$logger = Logger.new(log_path, 'weekly')
$logger.formatter = proc do |severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end

Telegram::Bot::Client.run(Bot_Token_Main) do |bot|
  bot.listen do |message|
    $bot = bot.api 
    $mes = message 

    begin
      handle if $mes
    rescue StandardError => e
      $bot.send_message(text: e, chat_id: My_chat_id)
      $bot.send_message(text: e.backtrace, chat_id: My_chat_id)
    end
  end
end
