require_relative 'requires'
require_all "#{ROOT}/moderator"

File.open("#{ROOT}/tmp/moderator.pid", 'a') { |pids_file| pids_file.puts Process.pid }

log_path = "#{ROOT}/logs/moderator.log"
$logger = Logger.new(log_path, 'weekly')
$logger.formatter = proc do |severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end


Telegram::Bot::Client.run(Bot_Token_Moderator) do |bot|
  bot.listen do |message|
    $bot = bot.api
    $mes = message

    begin
      handle
    rescue StandardError => e
      $bot.send_message(text: e, chat_id: My_Chat_Id)
      $bot.send_message(text: e.backtrace, chat_id: My_chat_id)

    end
  end
end
