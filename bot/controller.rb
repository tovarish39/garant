class Event_bot
  include AASM

  aasm whiny_transitions: false 

  aasm do
    state :start, :await_userTo_data, :userTo, :await_role, :await_type_of_currencies, :await_specific_currency, :await_amount, :await_conditions, :confirm_new_deal
    state :comments, :types_of_disput, :specific_disputs

    # after_all_transitions :log_status_change

    event :selecting_language do
        transitions from: :start,       to: :start,       after: :view_languages
    end

    event :text_message do

      transitions from: :start,             to: :await_userTo_data, after: :find_userTo,      if: ->(mes, lang) { mes.text == Find_user[lang]}#
   
      transitions from: :await_userTo_data, to: :await_userTo_data, after: :find_userTo,      if: ->(mes, lang) { mes.text == Find_user[lang]}#
      transitions from: :await_userTo_data, to: :userTo,            after: :run_to_userTo,    if:     :userTo_exist?#
      transitions from: :await_userTo_data, to: :await_userTo_data, after: :userTo_not_found, unless: :userTo_exist?#
#
      transitions from: :userTo,            to: :await_userTo_data, after: :find_userTo,      if: ->(mes, lang) { mes.text == Find_user[lang]}#

      transitions from: :await_amount,      to: :await_conditions,  after: :choose_conditions,if:     ->(mes)   { mes.text =~/^\s*[\d]+([,\.][\d]+)?\s*$/} # валидный из интернета, не вникал . только цифри и одна точка или запятая
      transitions from: :await_amount,      to: :await_amount,      after: :amount_invalid,   unless: ->(mes)   { mes.text =~/^\s*[\d]+([,\.][\d]+)?\s*$/} # из интернета, не вникал . только цифри и одна точка или запятая

      transitions from: :await_conditions,  to: :confirm_new_deal,  after: :confirming#

      transitions from: :start,             to: :start,             after: :start  # на любой остальной текст

    end

    event :callback_message do

      transitions from: :start,                    to: :start,                    after: :language_selected,        if: ->(mes, lang){mes.data =~ /Выбранный язык/ && lang == nil}
                 
      transitions from: :await_userTo_data,        to: :start,                    after: :start,                    if: ->(mes, lang){$mes.data == 'Cancel'}#
             
      transitions from: :userTo,                   to: :comments,                 after: :comments,                 if: ->(mes, lang){$mes.data =~ /Отзывы/}#       
      transitions from: :userTo,                   to: :types_of_disput,          after: :view_types_of_disputs,    if: ->(mes, lang){$mes.data =~ /Споры/}#
      transitions from: :userTo,                   to: :await_role,               after: :choose_role,              if: ->(mes, lang){$mes.data =~ /Предложить сделку/}#
                 
      transitions from: :comments,                 to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/}# 
                 
      transitions from: :types_of_disput,          to: :specific_disputs,         after: :disputs_won,              if: ->(mes, lang){$mes.data =~ /Выйграл споров/}# 
      transitions from: :types_of_disput,          to: :specific_disputs,         after: :disputs_lost,             if: ->(mes, lang){$mes.data =~ /Проиграл споров/}# 
      transitions from: :types_of_disput,          to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/} #
             
      transitions from: :specific_disputs,         to: :types_of_disput,          after: :view_types_of_disputs,    if: ->(mes, lang){$mes.data =~ /Назад к спорам/}#
       
      transitions from: :await_role,               to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/}#
      transitions from: :await_role,               to: :await_type_of_currencies, after: :choose_type_of_currencies,if: ->(mes, lang){$mes.data =~ /Я продавец/}#
      transitions from: :await_role,               to: :await_type_of_currencies, after: :choose_type_of_currencies,if: ->(mes, lang){$mes.data =~ /Я покупатель/}#
         
      transitions from: :await_type_of_currencies, to: :await_specific_currency,  after: :choose_specific_currency, if: ->(mes, lang){$mes.data =~ /Криптовалюта/}#
      transitions from: :await_type_of_currencies, to: :await_role,               after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к действиям/}#
         
      transitions from: :await_specific_currency,  to: :await_amount,             after: :choose_amount,            if: ->(mes, lang){$mes.data =~ /Валюта сделки/}#
      transitions from: :await_specific_currency,  to: :await_type_of_currencies, after: :choose_type_of_currencies,if: ->(mes, lang){$mes.data =~ /Назад к типам валют/}#
         
      transitions from: :confirm_new_deal,         to: :start,                    after: :deal_request,             if: ->(mes, lang){$mes.data =~ /Подтвердить сделку/}#
      transitions from: :confirm_new_deal,         to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/}#
   
    end
  end

#   def log_status_change
#     puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
#   end
end



def handle
  $user = searching_user()              # поиск ранее созданного user
  $user ||= create_user() unless $user  # создание user, если не найден
  $lang = $user.lang
  update_users_data_if_changed()
  
  puts "state after = #{$user.state}"

    if    $mes.class == Message && $mes.text


        event_bot = Event_bot.new
        event_bot.aasm.current_state = $user.state.to_sym # предидущее состояние

        event_bot.selecting_language($lang) unless $lang
        event_bot.text_message($mes, $lang) if     $lang
        
        new_state = event_bot.aasm.current_state          
        $user.update(state:new_state)                     # запись нового состояния

    elsif $mes.class == Callback
      puts "mes.data = #{$mes.data}"
# из любого состояния и не меняя состояние после обработки
        if    $mes.data =~ /response_seller to request_by_custumer/; handle_response_by_seller()   # действия от seller
        elsif $mes.data =~ /response_custumer to request_by_seller/; handle_response_by_custumer() # действия custumer
# обработка с изменением состояния 
        else 
          event_bot = Event_bot.new
          event_bot.aasm.current_state = $user.state.to_sym
          
          event_bot.callback_message($mes, $lang)

          new_state = event_bot.aasm.current_state
          $user.update(state:new_state)
        end
    end 
end

def send_message text, reply_markup = nil
    $bot.send_message(chat_id: ($mes.class == Callback) ? $mes.message.chat.id : $mes.chat.id, text:text, reply_markup:reply_markup, parse_mode: (text.include?('<')) ? "HTML" : nil)
end

def send_message_to_user text, to_user, reply_markup = nil
  $bot.send_message(chat_id: to_user.telegram_id, text:text, reply_markup:reply_markup, parse_mode: (text.include?('<')) ? "HTML" : nil)
end

def delete_pushed
    $bot.delete_message(chat_id:$mes.message.chat.id, message_id:$mes.message.message_id)
end

def delete_text
    $bot.delete_message(chat_id:$mes.chat.id, message_id:$mes.message_id)
end

def edit_message text, reply_markup = nil
    $bot.edit_message_text(chat_id: $mes.message.chat.id, message_id:$mes.message.message_id, text:text, reply_markup:reply_markup, parse_mode: (text.include?('<')) ? "HTML" : nil)
end