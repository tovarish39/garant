class Event_bot
  include AASM

  aasm whiny_transitions: false 

  aasm do
    state :language 

    state :start

    state :await_userTo_data
    state :userTo
    state :currency_amount
    state :conditions
    state :confirmation_new_deal

    state :deals_menu, :await_disput_text



    before_all_events   :log_before
    after_all_events    :log_after
    error_on_all_events :log_error

    event :language_action, from: :language do
      transitions if: ->{!$user.lang_viewed},      after: :view_languages,    to: :language # один раз приходит сообщение с выбором языка
      transitions if: ->{text_mes?()},                 after: :delete_text,       to: :language # удаляем любое текстовое сообщение при не выбранном языке
      transitions if: ->{data?(/Выбранный язык/)}, after: :language_selected, to: :start    # кликнут "язык"
    end
# :start
    event :start_action, from: :start do
# /start 
      transitions if: ->{text_mes?('/start')},           after: :to_start,    to: :start
# 🔎Найти пользователя🔎
      transitions if: ->{text_mes?(T_find_user[$lang])}, after: :find_userTo, to: :await_userTo_data
# 🤝Сделки🤝      
      transitions if: ->{text_mes?(T_deals[$lang])},     after: :to_deals_menu, to: :deals_menu
    end
# 🔎Найти пользователя🔎    
## :await_userTo_data
    event :await_userTo_data_action, from: :await_userTo_data do
      transitions if: ->{text_mes?(T_cancel[$lang])},               after: :cancel,           to: :start             # "Отмена"
      transitions if: ->{user_shared?() && !bot_has_userTo?()}, after: :userTo_not_found, to: :await_userTo_data # userTo не найден 
      transitions if: ->{user_shared?() &&  bot_has_userTo?()}, after: :run_to_userTo,    to: :userTo            # userTo    найден 
      transitions if: ->{text_mes?()        && !bot_has_userTo?()}, after: :userTo_not_found, to: :await_userTo_data # userTo не найден 
      transitions if: ->{text_mes?()        &&  bot_has_userTo?()}, after: :run_to_userTo,    to: :userTo            # userTo    найден
    end

    event :userTo_action, from: :userTo do
## UserToActions
      transitions if: ->{data?(/Comments/)},                       after: :view_comments,             to: :userTo   #
      transitions if: ->{data?(/Disputs/)},                        after: :view_type_of_disputs,      to: :userTo   #
      transitions if: ->{data?(/Offer_deal/)},                     after: :choose_role,               to: :userTo   #
## Comments TypeOfDisputs Role CurrencyTypes     
      transitions if: ->{data?(/Back_to userTo_actions/)},         after: :to_userTo_from_back,       to: :userTo   # 
## TypeOfDisputs
      transitions if: ->{data?(/Won_disputs/)},                    after: :disputs_won,               to: :userTo   # 
      transitions if: ->{data?(/Lost_disputs/)},                   after: :disputs_lost,              to: :userTo   # 
## WonDisputs LostDisputs
      transitions if: ->{data?(/Back_to TypeOfDisputs/)},          after: :back_to_type_of_disputs,   to: :userTo   # 
## Role
      transitions if: ->{data?(/I`m custumer/)},                   after: :choose_type_of_currencies, to: :userTo   # 
      transitions if: ->{data?(/I`m seller/)},                     after: :choose_type_of_currencies, to: :userTo   # 
## CurrencyTypes
      transitions if: ->{data?(/Criptocurrencies/)},               after: :choose_specific_currency,  to: :userTo   # 
      transitions if: ->{data?(/Another/)},                                                           to: :userTo   # 
## Currencies
      transitions if: ->{data?(/back_to CurrencyTypes/)},          after: :back_to_CurrencyTypes,     to: :userTo   # 
      transitions if: ->{data?(/Currency/)},                       after: :choose_amount,             to: :currency_amount   #  
    end 
## :currency_amount
    event :currency_amount_action, from: :currency_amount do
      transitions if:     ->{text_mes?(/^\s*[\d]+([,\.][\d]+)?\s*$/)}, after: :choose_conditions,         to: :conditions
      transitions unless: ->{text_mes?(/^\s*[\d]+([,\.][\d]+)?\s*$/)}, after: :amount_invalid,            to: :currency_amount
    end
## :conditions
    event :conditions_action, from: :conditions do
      transitions if: ->{text_mes?()},                                 after: :to_confirming,             to: :confirmation_new_deal
    end
## :confirmation_new_deal
    event :confirmation_new_deal_action, from: :confirmation_new_deal do
      transitions if: ->{data?(/Confirming_new_deal/)},            after: :deal_request,              to: :start
      transitions if: ->{data?(/Cancel_new_deal/)},                after: :to_userTo_from_back,       to: :userTo
    end
# 🤝Сделки🤝 
## :deals_menu
    event :deals_menu_action, from: :deals_menu do
      transitions if: ->{data?(/Open_disput/) &&  valid_deal_status?() }, after: :to_await_disput_text, to: :await_disput_text
      transitions if: ->{data?(/Open_disput/) && !valid_deal_status?() }, after: :invalid_deal_status,  to: :deals_menu


      transitions if: ->{text_mes?(T_active[$lang]) && !user_has_active_deals?()}, after: :user_hasnot_active_deals, to: :deals_menu
      transitions if: ->{text_mes?(T_active[$lang]) &&  user_has_active_deals?()}, after: :deals_active,          to: :deals_menu
      transitions if: ->{text_mes?(T_back[$lang])},                                after: :to_start,                 to: :start
    end
## :await_disput_text
    event :await_disput_text_action, from: :await_disput_text do
      transitions if: ->{text_mes?(T_cancel[$lang])}, after: :to_deals_menu,  to: :deals_menu
      transitions if: ->{text_mes?()},                after: :create_dispute, to: :deals_menu
    end

  end
  def log_before  
     $logger.info("BEFORE ; user_id = #{$user.id} ; from_state = #{self.aasm.current_state} ; #{income_message()}" )
  end
  def log_after
     $logger.info("AFTER  ; user_id = #{$user.id} ; new_state  = #{self.aasm.current_state}" )
  end
  def log_error exception
    $logger.error("ERR ; user_id = #{$user.id} #{exception}")
  end

end



def handle
  $user = searching_user()              # поиск ранее созданного user
  $user ||= create_user() unless $user  # создание user, если не найден
  $lang = $user.lang
  update_user_info_if_changed()
  $chat_id = $mes.class == MessageClass ? $mes.chat.id : $mes.message.chat.id

# при любом состоянии     не изменяя состояние
  if    $lang && data?(/Reject/); rejecting_deal() # реакция на действия других пользователей
  elsif $lang && data?(/Accept/); accepting_deal() # реакция на действия других пользователей
# при определённом состоянии изменяя состояние
  else  
    from_state = case 
                 when !$lang                        then 'language'  .to_sym  # язык не выбран
                 when click_main_button_or_start?() then 'start'     .to_sym  # кликнута главная кнопка меню или '/start'# пока только /start и найти пользователя
                 else                                     $user.state.to_sym  # предидущее состояние
                 end  

    St_machine.aasm.current_state = from_state
    St_machine.method("#{from_state}_action").call # event = #{from_state}_action

    new_state = St_machine.aasm.current_state          
    $user.update(state:new_state)                  # запись нового состояния
  end
end


