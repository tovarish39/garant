require 'telegram/bot'
require 'active_record'
require 'aasm'
require 'colorize'
require 'logger'

require_relative 'constants'

def require_all(path)
    Dir.glob("#{path}/**/*.rb").sort.each { |file| require file }
end
  

require_all MODELS_PATH
require_all COMMON


