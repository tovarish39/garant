# frozen_string_literal: true

ROOT_BOT    = ENV['BLACK_LIST']
TOKEN_BOT   = ENV['TOKEN_BLACK_LIST_BOT']
TOKEN_BOT_MODERATOR = ENV['TOKEN_BLACK_LIST_MODERATOR_BOT']
MY_CHAT_ID  = ENV['MY_CHAT_ID']
LIB_PATH    = "#{ROOT_BOT}/lib"
MODELS_PATH = "#{ROOT_BOT}/../adminka/app/models"
MAX_LENGTH_COMPLAINT_TEXT = 700
MIN_LENGTH_COMPLAINT_TEXT = 20
MAX_PHOTOS_SIZE = 20
MIN_PHOTOS_SIZE = 0
PHOTOS_PATH = "#{ROOT_BOT}/photos"
UPLOAD_ON_TELEGRAPH_PATH = "#{ROOT_BOT}/uploader/on_telegraph.rb"
UPLOAD_ON_TMP_PATH = "#{ROOT_BOT}/uploader/on_tmp.rb"
COMMON = "#{ROOT_BOT}/common"

CallbackQuery     = Telegram::Bot::Types::CallbackQuery
Message           = Telegram::Bot::Types::Message
ChatMemberUpdated = Telegram::Bot::Types::ChatMemberUpdated

Ru = 'Ru'
En = 'En'

params = {
  adapter: 'postgresql',
  host: 'localhost',
  port: 5432,
  dbname: 'garant_dev',
  user: ENV['Counter_invited_sites_db_dev_username'],
  password: ENV['Counter_invited_sites_db_dev_password']
}

ActiveRecord::Base.establish_connection(params)
