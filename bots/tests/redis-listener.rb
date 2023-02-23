require 'telegram/bot'
require 'json'
require 'active_record'
require 'redis'
require "logger"

require_relative "#{__dir__}/../adminka/app/models/application_record"
require_relative "#{__dir__}/../adminka/app/models/user"
require_relative "#{__dir__}/../adminka/app/models/payment"

require_relative './get-pay-data-by-freekassa'
require_relative './get-pay-data-by-browser'

logger = Logger.new('logs_kassa.log')
logger.formatter = proc do |severity, datetime, progname, msg|
    date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
    "#{severity.slice(0)}-[#{date_format}] pid=##{Process.pid} mes='#{msg}'\n"
end


username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/counter_invited_sites_development")
User.update_all(pending_from_kassa:false) # only on start

redis = Redis.new

Timeout_my = 30
Bot_token = ENV['Counter_invited_sites_bot_token']

Chat_id_my = '1964112204'
Ru = 'Русский'
En = 'English'

options = Selenium::WebDriver::Firefox::Options.new
options.add_argument('--headless') 
driver = Selenium::WebDriver.for :firefox, options: options



System_ids_1 = ['14', '15', '26'] 
System_ids_2 = ['16', '17', '18', '19', '20', '21', '24', '25', '39']
System_ids_3 = ['23']
System_ids_4 = ['8'] # Карта RUB
# 14 - USDT (ERC20)
# 15 - USDT (TRC20)
# 16 - Bitcoin Cash
# 17 - BNB
# 18 - DASH
# 19 - Dogecoin
# 20 - ZCash
# 21 - Monero
# 23 - Ripple
# 24 - Bitcoin
# 25 - Litecoin
# 26 - Ethereum
# 39 - Tron

url = "https://api.freekassa.ru/v1/orders/create" # создать заказ
# url = 'http://example.com' 

CardNumber = {Ru=>'<b>Номер карты: </b>',   En=>'<b>Card Number: </b>'} 
Address    = {Ru=>'<b>Адрес: </b>',   En=>'<b>Address: </b>'}
Currency   = {Ru=>'<b>Валюта: </b>',  En=>'<b>Currency: </b>'}
Sum        = {Ru=>'<b>Сумма: </b>',   En=>'<b>Amount: </b>'}
Memo_tag   = {Ru=>'<b>Memo/tag: </b>',En=>'<b>Memo/tag: </b>'}
Network    = {Ru=>'<b>Сеть: </b>',    En=>'<b>Network: </b>'}
B_footer   = ->(minutes, lg) {
  return "Сумма должна быть отправлена одним платежом \n\n Реквизиты действительны ровно #{minutes} минут, если не успеваете оплатить, пересоздайте сделку, иначе рискуете потерять деньги." if lg == Ru
  return "The amount must be sent in one payment \n\n Details are valid for exactly #{minutes} minutes, if you do not have time to pay, re-create the transaction, otherwise you risk losing money." if lg == En
}

Time_now = ->{Time.now}

Error_text = {Ru=>"Запрос отклонён, что-то пошло не так", En=>"Request denied, something went wrong"}


B_request_ok         = {Ru=>'Создание счета для оплаты ⏳️',                En=>'Create an invoice for payment ⏳️'}

#
# redis listen
#
begin
  redis.subscribe(:one, :two) do |on|
    on.message do |channel, message|

        data = message.split(':')
        payment_system_id = data[0]
        user_chat_id      = data[1]
        lg                = data[2]
        message_id        = data[3]

        user = User.find_by(telegram_id:user_chat_id)

        time_now = Time_now.call
        nonce =  "11111111" + time_now.to_i.to_s #  
        time_to_message = time_now.strftime('%d-%m-%y %T')

        Telegram::Bot::Client.run(Bot_token) do |bot|
          # анимация
          bot.api.edit_message_text(message_id:message_id, chat_id:user_chat_id, text:B_request_ok[lg])
          redis.hset(user_chat_id, 'animation', 'true')
          system("(ruby #{__dir__}/animation.rb #{user_chat_id} #{message_id} #{lg} &)")
          
   


          begin            
            response = freekassa_request(url, payment_system_id, nonce)
            location = response['location']

            logger.info(location)
            if payment_system_id != '33'
              data = get_pay_data(location, driver, payment_system_id)  # для 33 только location
              # logger.info(data)
              minutes = data.key?(:cardNumber) ? '10' : '60'

              text = ""
              text << "#{CardNumber[lg]}<code>#{data[:cardNumber]}</code>\n" if data[:cardNumber]
              text << "#{Address[lg]}<code>#{data[:address]}</code>\n"       if data[:address]
              text << "#{Currency[lg]}<code>#{data[:currency]}</code>\n"     if data[:currency]
              text << "#{Sum[lg]}<code>#{data[:sum]}</code>\n"               if data[:sum]
              text << "#{Memo_tag[lg]}<code>#{data[:memo_tag]}</code>\n"     if data[:memo_tag]
              text << "#{Network[lg]}<code>#{data[:network]}</code>\n"       if data[:network]
              text << "\n#{B_footer.call(minutes, lg)}"
            elsif payment_system_id == '33'
              text = "<code>#{response['location']}</code>"
            end

            user.payments.create(
              orderId:response['orderId'],
              orderHash:response['orderHash'],
              location:location
            )

            redis.hset(user_chat_id, 'animation', 'false')
            sleep 1 
            bot.api.edit_message_text(message_id:message_id, chat_id: user_chat_id, text: text, parse_mode:'HTML')



          rescue => exception
            logger.error(exception)

            # $bot.send_message(chat_id: Chat_id_my,   text:text,           parse_mode:"HTML")
            bot.api.edit_message_text(message_id:message_id, chat_id: user_chat_id, text:Error_text[lg], parse_mode:"HTML")
          ensure
            user.update(pending_from_kassa:false)
          end
      
       end
    end
  end
rescue Redis::BaseConnectionError => error
    logger.error("#{error}, retrying in 1s")
    sleep 1
    retry
end