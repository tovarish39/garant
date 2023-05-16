# username_pg = ENV['Counter_invited_sites_db_dev_username']
# password_pg = ENV['Counter_invited_sites_db_dev_password']
# ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")


params = {
    adapter: 'postgresql',
    host: 'localhost',
    port: 5432,
    dbname: 'garant_dev',
    user: ENV['Counter_invited_sites_db_dev_username'],
    password: ENV['Counter_invited_sites_db_dev_password']
  }
  
  ActiveRecord::Base.establish_connection(params)



ROOT                 = ENV['Garant_Bots_Path']

Bot_Token_Main       = ENV['Garant_Bot_Token_Main']
Bot_Token_Moderator  = ENV['Garant_Bot_Token_Moderator']

MODELS_PATH          = "#{ROOT}/../adminka/app/models"

COMMON               = "#{ROOT}/common"

My_Chat_Id           = ENV["Telegram_Chat_Id_My"]

Ru = 'Русский'
En = 'English'

DEAL_Closed_Statuses = ['finished by_custumer', 'canceled by_seller', 'finished by_moderator']






CallbackClass  = Telegram::Bot::Types::CallbackQuery
MessageClass   = Telegram::Bot::Types::Message
UpdateMember   = Telegram::Bot::Types::ChatMemberUpdated


