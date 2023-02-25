require 'telegram/bot'
require 'active_record'
require 'aasm'
require 'colorize'
require 'logger'
require 'redis'

# модели
require_relative '../../adminka/app/models/application_record'
require_relative '../../adminka/app/models/avalible_moderator'
require_relative '../../adminka/app/models/deal'
require_relative '../../adminka/app/models/dispute'
require_relative '../../adminka/app/models/moderator'
require_relative '../../adminka/app/models/taken_dispute'
require_relative '../../adminka/app/models/used_hash'
require_relative '../../adminka/app/models/user'



require_relative '../main-bot/handler/init'            # обработка при любом обращении к боту
require_relative '../main-bot/handler/from_all_states' # обработка при согласовании deal
require_relative '../main-bot/handler/common'

# states 
require_relative '../main-bot/handler/states/await_userTo_data'
require_relative '../main-bot/handler/states/conditions'
require_relative '../main-bot/handler/states/confirmation_new_deal'
require_relative '../main-bot/handler/states/currency_amount'
require_relative '../main-bot/handler/states/language'
require_relative '../main-bot/handler/states/start'
require_relative '../main-bot/handler/states/userTo'
require_relative '../main-bot/handler/states/deals_menu'
require_relative '../main-bot/handler/states/await_dispute_text'

# контроллер
require_relative '../main-bot/controller'

# константы
require_relative './constants'
require_relative './buttons'
require_relative './texts-by_bot'