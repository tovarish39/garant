

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

require_relative '../bot-main/handler/init'            # обработка при любом обращении к боту
require_relative '../bot-main/handler/from_all_states' # обработка при согласовании deal
require_relative '../common-sub_functions/bot-shortcuts'
require_relative '../common-sub_functions/logs'
require_relative '../common-sub_functions/sub'
require_relative '../common-sub_functions/validates'

# states
require_relative '../bot-main/handler/states/await_userTo_data'
require_relative '../bot-main/handler/states/conditions'
require_relative '../bot-main/handler/states/confirmation_new_deal'
require_relative '../bot-main/handler/states/currency_amount'
require_relative '../bot-main/handler/states/language'
require_relative '../bot-main/handler/states/start'
require_relative '../bot-main/handler/states/userTo'
require_relative '../bot-main/handler/states/deals_menu'
require_relative '../bot-main/handler/states/await_dispute_text'
require_relative '../bot-main/handler/states/profile'
require_relative '../bot-main/handler/states/marking_deal'
require_relative '../bot-main/handler/states/add_comment'

# контроллер
require_relative '../bot-main/controller'

# константы
require_relative './constants'
require_relative './buttons'
require_relative './texts-by_bot'
