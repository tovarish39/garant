require_relative '../config/requires.rb' #"#{ROOT_GARANT}/config/requires"
# require_all("#{ROOT_GARANT}/1_primary", without_file:__FILE__)
require_relative 'controller'
require_relative 'from_all_states'
# require "#{ROOT_GARANT}/1_primary/states/:start.rb"


# require_all "#{ROOT_GARANT}/1_primary/states"
Dir.glob("#{ROOT_GARANT}/1_primary/**/*.rb").sort.each do |file|
  next if file == __FILE__  # Пропустить файл, из которого происходит вызов
  puts file
  require_relative file
end

pid_file_path = "#{ROOT_GARANT}/tmp/1_primary.pid"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }

log_path = "#{ROOT_GARANT}/logs/1_primary.log"
$logger = Logger.new(log_path, 'weekly')
$logger.formatter = proc do |severity, datetime, _progname, msg|
  date_format = datetime.strftime('%Y-%m-%d %H:%M:%S')
  "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end

Telegram::Bot::Client.run(Bot_Token_1_PRIMARY) do |bot|
  bot.listen do |message|
    $bot = bot.api 
    $mes = message 

    # event_bot = StateMachine.new
    # puts "event_bot.may_start_action? from start #{event_bot.may_start_action?} " 

    # begin
      handle if $mes
      puts 
    # rescue StandardError => e
    #   $bot.send_message(text: e, chat_id: CHAT_ID_MY)
    #   $bot.send_message(text: e.backtrace, chat_id: CHAT_ID_MY)
    # end
  end
end
