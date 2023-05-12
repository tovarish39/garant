username_pg = ENV['Counter_invited_sites_db_dev_username']
password_pg = ENV['Counter_invited_sites_db_dev_password']
ActiveRecord::Base.establish_connection("postgres://#{username_pg}:#{password_pg}@localhost/garant_dev")

ROOT                 = ENV['Garant_Bots_Path']

Bot_Token_Main       = ENV['Garant_Bot_Token_Main']
Bot_Token_Moderator  = ENV['Garant_Bot_Token_Moderator']

MODELS_PATH          = "#{ROOT}/../adminka/app/models"

COMMON               = "#{ROOT}/common"

My_Chat_Id           = ENV["Telegram_Chat_Id_My"]

Ru = 'Русский'
En = 'English'







CallbackClass  = Telegram::Bot::Types::CallbackQuery
MessageClass   = Telegram::Bot::Types::Message
UpdateMember   = Telegram::Bot::Types::ChatMemberUpdated

