require 'telegram/bot'
require 'active_record'

# константы
require_relative './constants'

# модели
require_relative '../../adminka/app/models/application_record'
require_relative '../../adminka/app/models/user'
require_relative '../../adminka/app/models/deal'


# обработка при любом обращении к боту
require_relative '../handler/init'

# buttons 
require_relative '../handler/buttons/search_user/filling'
require_relative '../handler/buttons/search_user/comments'
require_relative '../handler/buttons/search_user/disputs'

# контроллер
require_relative '../handler/controller'

# p1