class Event_bot
  include AASM

  aasm whiny_transitions: false 

  aasm do
    state :language 
  
    state :start, :await_userTo_data, :userTo, :currency_amount, :confirmetion_new_deal

    after_all_transitions :log_status_change

    event :language_action, from: :language do
      transitions if: ->{!$user.lang_viewed},      after: :view_languages,    to: :language # один раз приходит сообщение с выбором языка
      transitions if: ->{text?()},                 after: :delete_text,       to: :language # удаляем любое текстовое сообщение при не выбранном языке
      transitions if: ->{data?(/Выбранный язык/)}, after: :language_selected, to: :start    # кликнут "язык"
    end

    event :start_action, from: :start do
# /start 
      transitions if: ->{text?('/start')},           after: :to_start,    to: :start
# 🔎Найти пользователя🔎
      transitions if: ->{text?(T_find_user[$lang])}, after: :find_userTo, to: :await_userTo_data
    end

    event :await_userTo_data_action, from: :await_userTo_data do
      transitions if: ->{text?() && !userTo_exist?()}, after: :userTo_not_found, to: :await_userTo_data # user не найден 
      transitions if: ->{text?() &&  userTo_exist?()}, after: :run_to_userTo,    to: :userTo            # user найден
      transitions if: ->{data?('Cancel')},             after: :cancel,           to: :start             # 
    end

    event :userTo_action, from: :userTo do
# UserToActions
      transitions if: ->{data?(/Comments/)},               after: :view_comments,        to: :userTo   #
      transitions if: ->{data?(/Disputs/)},                after: :view_type_of_disputs, to: :userTo   #
# Comments  TypeOfDisputs      
      transitions if: ->{data?(/Back_to userTo_actions/)}, after: :to_userTo_from_back, to: :userTo   # 
# TypeOfDisputs
      transitions if: ->{data?(/Won_disputs/)},            after: :disputs_won,  to: :userTo   # 
      transitions if: ->{data?(/Lost_disputs/)},           after: :disputs_lost, to: :userTo   # 
# WonDisputs LostDisputs
      transitions if: ->{data?(/Back_to TypeOfDisputs/)},  after: :back_to_type_of_disputs, to: :userTo   # 

    end 
    # state :start, :await_userTo_data, :userTo, :await_role, :await_type_of_currencies, :await_specific_currency, :await_amount, :await_conditions, :confirm_new_deal
    # state :comments, :types_of_disput, :specific_disputs

    # after_all_transitions :log_status_change

#     event :selecting_language do
#         transitions from: :start,       to: :start,       after: :view_languages
#     end

#     event :text_message do

#       transitions from: :start,             to: :await_userTo_data, after: :find_userTo,      if: ->(mes, lang) { mes.text == Find_user[lang]}#
   
#       transitions from: :await_userTo_data, to: :await_userTo_data, after: :find_userTo,      if: ->(mes, lang) { mes.text == Find_user[lang]}#
#       transitions from: :await_userTo_data, to: :userTo,            after: :run_to_userTo,    if:     :userTo_exist?#
#       transitions from: :await_userTo_data, to: :await_userTo_data, after: :userTo_not_found, unless: :userTo_exist?#
# #
#       transitions from: :userTo,            to: :await_userTo_data, after: :find_userTo,      if: ->(mes, lang) { mes.text == Find_user[lang]}#

#       transitions from: :await_amount,      to: :await_conditions,  after: :choose_conditions,if:     ->(mes)   { mes.text =~/^\s*[\d]+([,\.][\d]+)?\s*$/} # валидный из интернета, не вникал . только цифри и одна точка или запятая
#       transitions from: :await_amount,      to: :await_amount,      after: :amount_invalid,   unless: ->(mes)   { mes.text =~/^\s*[\d]+([,\.][\d]+)?\s*$/} # из интернета, не вникал . только цифри и одна точка или запятая

#       transitions from: :await_conditions,  to: :confirm_new_deal,  after: :confirming#

#       transitions from: :start,             to: :start,             after: :start  # на любой остальной текст

#     end

#     event :callback_message do

#       transitions from: :start,                    to: :start,                    after: :language_selected,        if: ->(mes, lang){mes.data =~ /Выбранный язык/ && lang == nil}
                 
#       transitions from: :await_userTo_data,        to: :start,                    after: :start,                    if: ->(mes, lang){$mes.data == 'Cancel'}#
             
#       transitions from: :userTo,                   to: :comments,                 after: :comments,                 if: ->(mes, lang){$mes.data =~ /Отзывы/}#       
#       transitions from: :userTo,                   to: :types_of_disput,          after: :view_types_of_disputs,    if: ->(mes, lang){$mes.data =~ /Споры/}#
#       transitions from: :userTo,                   to: :await_role,               after: :choose_role,              if: ->(mes, lang){$mes.data =~ /Предложить сделку/}#
                 
#       transitions from: :comments,                 to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/}# 
                 
#       transitions from: :types_of_disput,          to: :specific_disputs,         after: :disputs_won,              if: ->(mes, lang){$mes.data =~ /Выйграл споров/}# 
#       transitions from: :types_of_disput,          to: :specific_disputs,         after: :disputs_lost,             if: ->(mes, lang){$mes.data =~ /Проиграл споров/}# 
#       transitions from: :types_of_disput,          to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/} #
             
#       transitions from: :specific_disputs,         to: :types_of_disput,          after: :view_types_of_disputs,    if: ->(mes, lang){$mes.data =~ /Назад к спорам/}#
       
#       transitions from: :await_role,               to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/}#
#       transitions from: :await_role,               to: :await_type_of_currencies, after: :choose_type_of_currencies,if: ->(mes, lang){$mes.data =~ /Я продавец/}#
#       transitions from: :await_role,               to: :await_type_of_currencies, after: :choose_type_of_currencies,if: ->(mes, lang){$mes.data =~ /Я покупатель/}#
         
#       transitions from: :await_type_of_currencies, to: :await_specific_currency,  after: :choose_specific_currency, if: ->(mes, lang){$mes.data =~ /Криптовалюта/}#
#       transitions from: :await_type_of_currencies, to: :await_role,               after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к действиям/}#
         
#       transitions from: :await_specific_currency,  to: :await_amount,             after: :choose_amount,            if: ->(mes, lang){$mes.data =~ /Валюта сделки/}#
#       transitions from: :await_specific_currency,  to: :await_type_of_currencies, after: :choose_type_of_currencies,if: ->(mes, lang){$mes.data =~ /Назад к типам валют/}#
         
#       transitions from: :confirm_new_deal,         to: :start,                    after: :deal_request,             if: ->(mes, lang){$mes.data =~ /Подтвердить сделку/}#
#       transitions from: :confirm_new_deal,         to: :userTo,                   after: :run_to_userTo,            if: ->(mes, lang){$mes.data =~ /Назад к юзеру/}#
   


      
    # end
  end
  def log_status_change
    puts "user_telegram_id #{$user.telegram_id.colorize(:blue)} (event: #{aasm.current_event.to_s.colorize(:blue)} #{("callbackData = " + $mes.data.colorize(:yellow)) if data?()})"
  end
end



def handle
  $user = searching_user()              # поиск ранее созданного user
  $user ||= create_user() unless $user  # создание user, если не найден
  $lang = $user.lang
  update_user_info_if_changed()
  $chat_id = $mes.class == MessageClass ? $mes.chat.id : $mes.message.chat.id

  from_state = case 
               when !$lang                        then 'language'  .to_sym  # язык не выбран
               when click_main_button_or_start?() then 'start'     .to_sym  # кликнута главная кнопка меню или '/start'# пока только /start и найти пользователя
               else                                     $user.state.to_sym  # предидущее состояние
               end  

  St_machine.aasm.current_state = from_state
  St_machine.method("#{from_state}_action").call # event = #{from_state}_action

  new_state = St_machine.aasm.current_state          
  $user.update(state:new_state)                  # запись нового состояния

#         if    $mes.data =~ /response_seller to request_by_custumer/; handle_response_by_seller()   # действия от seller
#         elsif $mes.data =~ /response_custumer to request_by_seller/; handle_response_by_custumer() # действия custumer

end

def  click_main_button_or_start? =  text? && T_start_actions.include?($mes.text) # любая кнопка из главного меню или '/start'

def comparing message, compare
  return true if !compare
  with_text  = compare.class == String
  with_regex = compare.class == Regexp 
  return true if with_text  && message == compare
  return true if with_regex && message =~ compare
  false
end

def text?(compare = nil) # сообщение text любое или соответствие сравниваемому
   return nil if $mes.class != MessageClass
   text = $mes.text
   comparing(text, compare)
end

def data?(compare = nil) # сообщение callback любое или соответствие сравниваемому
  return nil if $mes.class != CallbackClass
  data = $mes.data
  comparing(data, compare)
end

def send_message text, reply_markup = nil
  $bot.send_message(chat_id: $chat_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")
end

def send_message_to_user text, to_user, reply_markup = nil
  $bot.send_message(chat_id: to_user.telegram_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")
end

def delete_pushed
  $bot.delete_message(chat_id:$chat_id, message_id:$mes.message.message_id)
end

def delete_text
  $bot.delete_message(chat_id:$chat_id, message_id:$mes.message_id)
end

def edit_message text, reply_markup = nil
  $bot.edit_message_text(chat_id: $chat_id, message_id:$mes.message.message_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")
end