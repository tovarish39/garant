require 'telegram/bot'
require 'active_record'
require 'aasm'
require 'colorize'
require 'logger'
# require 'redis'

require_relative 'config'

def require_all(path)
    Dir.glob("#{path}/**/*.rb").sort.each do |file|
      require file
    end
end
  

require_all MODELS_PATH
require_all COMMON



