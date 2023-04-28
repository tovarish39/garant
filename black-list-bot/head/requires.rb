# frozen_string_literal: true

require 'telegram/bot'
require 'active_record'
require 'aasm'
require 'logger'

require_relative 'config'
require_relative 'button'
require_relative 'text'
require_relative 'markup'
require_relative 'inline'
require_relative 'shorts'


def require_all(path)
  Dir.glob("#{path}/**/*.rb").sort.each do |file|
    require file
  end
end

require_all LIB_PATH
require_all MODELS_PATH
