require 'telegram/bot'
require 'active_record'
require 'aasm'
require 'colorize'
require 'logger'

# модели
require_relative '../../adminka/app/models/application_record'
require_relative '../../adminka/app/models/avalible_moderator'
require_relative '../../adminka/app/models/deal'
require_relative '../../adminka/app/models/dispute'
require_relative '../../adminka/app/models/moderator'
require_relative '../../adminka/app/models/taken_dispute'
require_relative '../../adminka/app/models/used_hash'
require_relative '../../adminka/app/models/user'



require_relative '../handler/init'            # обработка при любом обращении к боту
require_relative '../handler/from_all_states' # обработка при согласовании deal
require_relative '../handler/common'

# states 
require_relative '../handler/states/await_userTo_data'
require_relative '../handler/states/conditions'
require_relative '../handler/states/confirmation_new_deal'
require_relative '../handler/states/currency_amount'
require_relative '../handler/states/language'
require_relative '../handler/states/start'
require_relative '../handler/states/userTo'
require_relative '../handler/states/deals_menu'
require_relative '../handler/states/await_dispute_text'

# контроллер
require_relative '../controller'

# константы
require_relative './constants'
require_relative './buttons'
require_relative './texts-by_bot'