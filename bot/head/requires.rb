require 'telegram/bot'
require 'active_record'
require 'aasm'
require 'colorize'



# модели
require_relative '../../adminka/app/models/application_record'
require_relative '../../adminka/app/models/user'
require_relative '../../adminka/app/models/deal'


# обработка при любом обращении к боту
require_relative '../handler/init'

# buttons 
require_relative '../handler/buttons/search_user/deal'
require_relative '../handler/buttons/search_user/comments'
require_relative '../handler/buttons/search_user/disputs'

#обработка при согласовании deal
require_relative '../handler/conformation_by_users'

# контроллер
require_relative '../controller'

# константы
require_relative './constants'