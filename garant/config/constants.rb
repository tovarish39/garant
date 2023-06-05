params = {
    adapter: 'postgresql',
    host: 'localhost',
    port: 5432,
    dbname: 'garant_dev',
    user: ENV['Counter_invited_sites_db_dev_username'],
    password: ENV['Counter_invited_sites_db_dev_password']
}

ActiveRecord::Base.establish_connection(params)

Bot_Token_1_PRIMARY   = ENV['Garant_Bot_Token_Main']
Bot_Token_2_SECONDARY = ENV['Garant_Bot_Token_Moderator']
CHAT_ID_MY            = ENV["Telegram_Chat_Id_My"]
ROOT_GARANT           = ENV['Garant_Bots_Path']

MODELS_PATH          = "#{ROOT_GARANT}/../adminka/app/models"
COMMON               = "#{ROOT_GARANT}/common"

Ru = 'Русский'
En = 'English'

DEAL_Closed_Statuses = ['finished by_custumer', 'canceled by_seller', 'finished by_moderator']

CallbackQuery        = Telegram::Bot::Types::CallbackQuery
Message              = Telegram::Bot::Types::Message
ChatMemberUpdated    = Telegram::Bot::Types::ChatMemberUpdated
ReplyKeyboardMarkup  = Telegram::Bot::Types::ReplyKeyboardMarkup
InlineKeyboardMarkup = Telegram::Bot::Types::InlineKeyboardMarkup
InlineKeyboardButton = Telegram::Bot::Types::InlineKeyboardButton