File.open("#{__dir__}/../tmp/pids.txt", 'a') {|pids_file| pids_file.puts Process.pid}

require_relative '../head/requires'

$logger = Logger.new("#{__dir__}/../logs/main-bot.log", 'weekly')
$logger.formatter = proc do |severity, datetime, progname, msg|
    date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
    "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end

Telegram::Bot::Client.run(Bot_token) do |bot|
    bot.listen do |message|

        $bot = bot.api      # глобальное определение, чтоб не передавать в каждую функцию,
        $mes = message      # обновляются при каждом новом сообщении
        
        handle() if   $mes

    end
end