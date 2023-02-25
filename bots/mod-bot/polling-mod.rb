File.open("#{__dir__}/../tmp/pids.txt", 'a') {|pids_file| pids_file.puts Process.pid}

require_relative '../head/requires'
require_relative './mod-functions'

$logger = Logger.new("#{__dir__}/../logs/mod-bot.log", 'weekly')
$logger.formatter = proc do |severity, datetime, progname, msg|
    date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
    "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end

token = ENV["Garant_moderator_bot"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    $bot = bot.api
    $mes = message

    $mod = searching_user('Moderator')              # поиск ранее созданного user
    $mod ||= create_user('Moderator') unless $mod  # создание user, если не найден
    # $lang = $mod.lang
    update_user_info_if_changed('Moderator')
    avalible_moderator_telegram_ids = AvalibleModerator.all.map(&:telegram_id)
    $chat_id = $mes.class == MessageClass ? $mes.chat.id : $mes.message.chat.id

    if    $mod.username == "-" ; require_username()                       # обязательный юзернейм 
    elsif avalible_moderator_telegram_ids.include?($mod.telegram_id)      # модератор есть в списке возможных модераторов
      if    $mod.state == 'pending_comment'; finishing_dispute()          # отмена || завершение обработки спора
      elsif data?(/Accept/);                 handle_acception()           # модератор принимает спор
      elsif data?(/Decision/);               handle_decision()            # seller_lost || custumer_lost || nonobservance
      elsif text_mes?('Открытые споры');     list_opened_disputes()       # список открытых, но не принятых споров
      elsif text_mes?('Мои споры');          list_my_inProcess_disputes() # список моих споров "в процессе"
      elsif text_mes?('История споров');     list_my_closed_disputs()     # cписок ранее обработанных споров
      elsif text_mes?();                     view_menu()                  # панель меню
      end

    end
  end
end