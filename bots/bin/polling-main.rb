File.open("#{__dir__}/../tmp/pids.txt", 'a') {|pids_file| pids_file.puts Process.pid}

require_relative '../head/requires'


Telegram::Bot::Client.run(Bot_token) do |bot|
    bot.listen do |message|

        $bot = bot.api      # глобальное определение, чтоб не передавать в каждую функцию,
        $mes = message      # обновляются при каждом новом сообщении
        
        handle() if   $mes

    end
end