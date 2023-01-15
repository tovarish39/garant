require 'telegram/bot'
require 'active_record'

# константы
require_relative './constants'

# модели
require_relative '../../adminka/app/models/application_record'
require_relative '../../adminka/app/models/user'


# обработка при любом обращении к боту
require_relative '../handler/init'

# buttons 
require_relative '../handler/buttons/new_trans'

# контроллер
require_relative '../handler/controller'
