class Event_bot
  include AASM

  # aasm whiny_transitions: false 

  aasm do
    state :language 

    state :start

# 🔎Найти пользователя🔎
    state :await_userTo_data
    state :userTo
    state :currency_amount
    state :conditions
    state :confirmation_new_deal
# 🤝Сделки🤝
    state :deals_menu, :await_disput_text
# 👨‍💼Профиль👨‍💼
    state :profile


    before_all_events   :log_before
    after_all_events    :log_after
    error_on_all_events :log_error

    event :language_action, from: :language do
      transitions if: ->{!$user.lang_viewed},      after: :view_languages,    to: :language # один раз приходит сообщение с выбором языка
      transitions if: ->{text_mes?()},             after: :delete_text,       to: :language # удаляем любое текстовое сообщение при не выбранном языке
      transitions if: ->{data?(/Выбранный язык/)}, after: :language_selected, to: :start    # кликнут "язык"
    end
# :start
    event :start_action, from: :start do
# /start 
      transitions if: ->{text_mes?('/start')},         after: :to_start,      to: :start            
# 🔎Найти пользователя🔎
      transitions if: ->{text_mes?(T_find_user[$lg])}, after: :find_userTo,   to: :await_userTo_data
# 🤝Сделки🤝      
      transitions if: ->{text_mes?(T_deals[$lg])},     after: :to_deals_menu, to: :deals_menu
# 👨‍💼Профиль👨‍💼
      transitions if: ->{text_mes?(T_profile[$lg]) &&  empty_wallet?()},   after: :empty_wallet,  to: :start
      transitions if: ->{text_mes?(T_profile[$lg]) && !empty_wallet?()},   after: :view_profile,  to: :profile
    end


# 🔎Найти пользователя🔎    
## :await_userTo_data
    event :await_userTo_data_action, from: :await_userTo_data do
      transitions if: ->{text_mes?(T_cancel[$lg])},             after: :cancel,           to: :start             # "Отмена"
      transitions if: ->{user_shared?() && !bot_has_userTo?()}, after: :userTo_not_found, to: :await_userTo_data # userTo не найден из своего списка пользователей
      transitions if: ->{user_shared?() &&  bot_has_userTo?()}, after: :run_to_userTo,    to: :userTo            # userTo    найден из своего списка пользователей
      transitions if: ->{text_mes?()    && !bot_has_userTo?()}, after: :userTo_not_found, to: :await_userTo_data # userTo не найден из id || username 
      transitions if: ->{text_mes?()    &&  bot_has_userTo?()}, after: :run_to_userTo,    to: :userTo            # userTo    найден из id || username
    end

    event :userTo_action, from: :userTo do
## UserToActions
      transitions if: ->{data?(/Comments/)},               after: :view_comments,             to: :userTo   # "Отзывы"
      transitions if: ->{data?(/Disputes/)},                after: :view_type_of_disputes,      to: :userTo   # "Комментарии"
      transitions if: ->{data?(/Offer_deal/)},             after: :choose_role,               to: :userTo   # "Предложить сделку"
## Comments TypeOfDisputes Role CurrencyTypes     
      transitions if: ->{data?(/Back_to userTo_actions/)}, after: :to_userTo_from_back,       to: :userTo   # "Назад"
## TypeOfDisputes
      transitions if: ->{data?(/Won_disputes/)},            after: :disputes_won,               to: :userTo   # "Выйграл споров"
      transitions if: ->{data?(/Lost_disputes/)},           after: :disputes_lost,              to: :userTo   # "Проиграл споров"
## WonDisputes LostDisputes
      transitions if: ->{data?(/Back_to TypeOfDisputes/)},  after: :back_to_type_of_disputes,   to: :userTo   # "Назад"
## Role
      transitions if: ->{data?(/I`m custumer/)},           after: :choose_type_of_currencies, to: :userTo   # "Я покупатель"
      transitions if: ->{data?(/I`m seller/)},             after: :choose_type_of_currencies, to: :userTo   # "Я продавец"
## CurrencyTypes
      transitions if: ->{data?(/Criptocurrencies/)},       after: :choose_specific_currency,  to: :userTo   # "Криптовалюта"
      transitions if: ->{data?(/Another/)},                                                   to: :userTo   # ещё не сделано
## Currencies
      transitions if: ->{data?(/back_to CurrencyTypes/)},  after: :back_to_CurrencyTypes,     to: :userTo          # "Назад"
      transitions if: ->{data?(/Currency/)},               after: :choose_amount,             to: :currency_amount # Выбор определённой валюты
    end 
## :currency_amount
    event :currency_amount_action, from: :currency_amount do
      transitions if:     ->{text_mes?(/^\s*[\d]+([,\.][\d]+)?\s*$/)}, after: :choose_conditions, to: :conditions      #    валидное количество валюты 
      transitions unless: ->{text_mes?(/^\s*[\d]+([,\.][\d]+)?\s*$/)}, after: :amount_invalid,    to: :currency_amount # не валидное количество валюты
    end
## :conditions
    event :conditions_action, from: :conditions do
      transitions if: ->{text_mes?()},                     after: :to_confirming,       to: :confirmation_new_deal # ввод условий сделки
    end
## :confirmation_new_deal
    event :confirmation_new_deal_action, from: :confirmation_new_deal do
      transitions if: ->{data?(/Confirming_new_deal/)},    after: :deal_request,        to: :start  # создание сделки и отправка на подтверждение seller || custumer
      transitions if: ->{data?(/Cancel_new_deal/)},        after: :to_userTo_from_back, to: :userTo # "Отмена" сделки (не создание)
    end
# 🤝Сделки🤝 
## :deals_menu
    event :deals_menu_action, from: :deals_menu do
## 'Открыть спор'
      transitions if:->{data?(/Open_disput/) &&  valid_deal_status?() }, after: :to_await_disput_text,          to: :await_disput_text # 
      transitions if:->{data?(/Open_disput/) && !valid_deal_status?() }, after: :invalid_deal_status,           to: :deals_menu        # "Открыть спор" уже была кем-то нажата
## 'Подтвердить'  покупатель подтверждает окончание сделки, средства переводятся продавцу
      transitions if:->{data?(/Finish_deal/) &&  valid_deal_status?() }, after: :finishing_deal_by_custumer,    to: :deals_menu # 
      transitions if:->{data?(/Finish_deal/) && !valid_deal_status?() }, after: :invalid_deal_status,           to: :deals_menu # "Открыть спор" уже была кем-то нажата
## "Отменить сделку" продавец отменяет сделку, средства переводятся покупателю
      transitions if:->{data?(/Cancel_exist_deal/) &&  valid_deal_status?() }, after: :canceled_deal_by_seller, to: :deals_menu # 
      transitions if:->{data?(/Cancel_exist_deal/) && !valid_deal_status?() }, after: :invalid_deal_status,     to: :deals_menu # "Открыть спор" уже была кем-то нажата

## 'Активные'
      transitions if:->{text_mes?(T_active[$lg])        && !has_active_deals?()},   after: :hasnot_active_deals,  to: :deals_menu #  отсутствуют
      transitions if:->{text_mes?(T_active[$lg])        &&  has_active_deals?()},   after: :view_active_deals,    to: :deals_menu # присутствуют
## 'Запросы'
      transitions if:->{text_mes?(T_requests[$lg])      && !has_request_deals?()},  after: :hasnot_request_deals, to: :deals_menu #  отсутствуют
      transitions if:->{text_mes?(T_requests[$lg])      &&  has_request_deals?()},  after: :view_request_deals,   to: :deals_menu # присутствуют
## 'Споры'
      transitions if:->{text_mes?(T_disputes[$lg])      &&  !has_dispute_deals?()}, after: :hasnot_dispute_deals, to: :deals_menu #  отсутствуют
      transitions if:->{text_mes?(T_disputes[$lg])      &&   has_dispute_deals?()}, after: :view_dispute_deals,   to: :deals_menu # присутствуют
## 'История сделок'
      transitions if:->{text_mes?(T_deals_history[$lg]) && !has_history_deals?()},  after: :hasnot_history_deals, to: :deals_menu #  отсутствуют 
      transitions if:->{text_mes?(T_deals_history[$lg]) &&  has_history_deals?()},  after: :view_history_deals,   to: :deals_menu # присутствуют
## 'Назад'
      transitions if: ->{text_mes?(T_back[$lg])},                                after: :to_start,                 to: :start      # "Назад"
    end
## :await_disput_text
    event :await_disput_text_action, from: :await_disput_text do
      transitions if: ->{text_mes?(T_cancel[$lg])}, after: :to_deals_menu,  to: :deals_menu # "Отмена" создания спора
      transitions if: ->{text_mes?()},              after: :create_dispute, to: :deals_menu # создание спора
    end
## :profile
    event :profile_action, from: :profile do
      transitions if:->{data?('Extract')}, after: :extracting, to: :start
    end

  end
  def log_before  
     $logger.info("BEFORE ; user_id = #{$user.id} ; from_state = #{self.aasm.current_state} ; '#{income_message()}'" )
  end
  def log_after
     $logger.info("AFTER  ; user_id = #{$user.id} ; new_state  = #{self.aasm.current_state}" )
  end
  def log_error exception
#     fail
    $logger.error("ERR ; user_id = #{$user.id} #{exception}")
  end

end



def handle
  $user = searching_user()              # поиск ранее созданного user
  $user ||= create_user() unless $user  # создание user, если не найден
  $lg = $user.lang
  update_user_info_if_changed()         # обновление информации о user, если изменил
  $chat_id = $mes.class == MessageClass ? $mes.chat.id : $mes.message.chat.id

# при любом состоянии     не изменяя состояние
  if    $lg && data?(/Reject/); rejecting_deal() # отклонение    сделки seller || custumer
  elsif $lg && data?(/Accept/); accepting_deal() # подтверждение сделки seller || custumer
# при определённом состоянии изменяя состояние
  else  
    from_state = case 
                 when !$lg                          then 'language'  .to_sym  # язык не выбран, перевод в "language" состояние
                 when click_main_button_or_start?() then 'start'     .to_sym  # кликнута главная кнопка меню или '/start', перевод в "start" состояние
                 else                                     $user.state.to_sym  # предидущее состояние
                 end  

    St_machine.aasm.current_state = from_state    
    St_machine.method("#{from_state}_action").call # event = #{from_state}_action

    new_state = St_machine.aasm.current_state          
    $user.update(state:new_state)                  # запись нового состояния
  end
end

