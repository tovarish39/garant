module IB
    IB = lambda { |text, callback_data|
        Telegram::Bot::Types::InlineKeyboardButton.new(text: text, callback_data: callback_data)
      }

    def self.ru = IB.call(Button.ru, "#{Ru}/lg")     
    def self.en = IB.call(Button.en, "#{En}/lg")   
          
end