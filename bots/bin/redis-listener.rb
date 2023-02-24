File.open("#{__dir__}/../tmp/pids.txt", 'a') {|pids_file| pids_file.puts Process.pid}

require 'telegram/bot'
require 'active_record'
require 'redis'

# модели
require_relative '../../adminka/app/models/application_record'
require_relative '../../adminka/app/models/avalible_moderator'
require_relative '../../adminka/app/models/deal'
require_relative '../../adminka/app/models/dispute'
require_relative '../../adminka/app/models/moderator'

IB = ->(text, callback_data){Telegram::Bot::Types::InlineKeyboardButton.new(text:text, callback_data:callback_data)}
IM = ->(inline_keyboard)    {Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard:inline_keyboard)}


username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")


token = ENV["Garant_moderator_bot"]
redis = Redis.new

ru = "Русский"
en = "English"
B_disput_offer = -> (dispute, lg){
  return %{} if lg == ru
  return %{} if lg == en
}

IM_dispute_offer = -> (dispute, lg) {IM.call()}


#
# redis listen
#
begin
  redis.subscribe(:one, :two) do |on|
    on.message do |channel, dispute_id|
      dispute = Dispute.find(dispute_id)
      avalible_morerator_telegram_ids = AvalibleModerator.all.map(&:telegram_id) 

      Telegram::Bot::Client.run(token) do |bot|
        Moderator.all.each do |moderator|
          if avalible_morerator_telegram_ids.include?(moderator.telegram_id)
            lg = moderator.lang
            dispute.sended_to_moderators << moderator.id
            bot.api.send_message(
              chat_id:moderator.telegram_id, 
              text:B_disput_offer.call(dispute, lg),
              reply_markup:IM_dispute_offer.call(dispute, lg)
            )
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
