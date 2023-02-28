File.open("#{__dir__}/../tmp/pids.txt", 'a') {|pids_file| pids_file.puts Process.pid}

require_relative '../head/requires'

$logger = Logger.new("#{__dir__}/../logs/redis.log", 'weekly')
$logger.formatter = proc do |severity, datetime, progname, msg|
    date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
    "#{severity.slice(0)} date=[#{date_format}] pid=##{Process.pid} message='#{msg}'\n"
end

token_mod  = ENV["Garant_moderator_bot"]
token_main = ENV["Garant_bot_token"]
redis = Redis.new




#
# redis listen
#
begin
  redis.subscribe(:one, :two) do |on|
    on.message do |channel, message|
      $logger.info("channel, message = #{channel} : #{message}")
# seller || custumer открыл спор
      if channel == 'one'
        dispute = Dispute.find(message)
        # проверка модераторов по white list
        avalible_morerator_telegram_ids = AvalibleModerator.all.map(&:telegram_id) 

        Telegram::Bot::Client.run(token_mod) do |bot|
          $bot = bot.api

          Moderator.all.each do |moderator|
            if avalible_morerator_telegram_ids.include?(moderator.telegram_id)
              $chat_id = moderator.telegram_id
              deal     = dispute.deal
              seller   = User.find(deal.seller_id) 
              custumer = User.find(deal.custumer_id)
              lg = Ru # moderator.lang
              initiator = dispute.created_by_user_id == seller.id.to_s ? B_by_seller[lg] : B_by_custumer[lg]
              mes = send_message(
                B_disput_offer.call(seller, custumer, deal, dispute, initiator, lg),
                IM_dispute_offer.call(dispute, lg)
              )
              dispute.sended_to_moderators << {moderator.id => mes['result']['message_id'].to_s}
              dispute.save
            end
          end
        end
# из mod-bot модератор взял спор в обработку или обработал спор
      elsif channel == 'two'
        data = message.split(':')
        dispute_id         = data.first
        action             = data.last 
        dispute = Dispute.find(dispute_id)
        seller   = User.find(dispute.deal.seller_id)  
        custumer = User.find(dispute.deal.custumer_id)
        Telegram::Bot::Client.run(token_main) do |bot|
          $bot = bot.api
# модератор принял спор в обработку
          if action == 'get-dispute'
            moderator_username = dispute.moderator.username
            [seller, custumer].each do |to_user|
              send_message_to_user("Спор по сделки ##{dispute.deal.hash_name} ведёт @#{moderator_username}", to_user)
            end
# модератор определил решение по спору
          elsif action == 'push-decision'
            decision = dispute.dispute_lost # 'seller_lost' || 'custumer_lost' || 'all_lost'
            currency = dispute.deal.currency
            amount   = dispute.deal.amount

            case decision
            when 'seller_lost'
              custumers_wallet = custumer.wallet
              # обновление кошелька Покупателя в определённой валюте
              custumers_wallet.key?(currency) ? custumers_wallet[currency] = custumers_wallet[currency].to_i + amount.to_i : custumers_wallet[currency] = amount.to_i
              custumer.save
            when 'custumer_lost'
              sellers_wallet = seller.wallet
              # обновление кошелька Покупателя в определённой валюте
              sellers_wallet.key?(currency) ? sellers_wallet[currency] = sellers_wallet[currency].to_i + amount.to_i : sellers_wallet[currency] = amount.to_i
              seller.save
            when 'all_lost'
            end

            text = "Спор по сделке ##{dispute.deal.hash_name} \n"
            text += B_dispute_comment.call(dispute)
            [seller, custumer].each {|to_user| send_message_to_user(text, to_user)} 
          end
        end
      end
    end
  end
rescue Redis::BaseConnectionError => error
    logger.error("#{error}, retrying in 1s")
    sleep 1
    retry
end
