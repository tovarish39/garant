class StateMachine
    class_eval do
      include AASM
      aasm do
        state :await_userTo_data
  
        event :await_userTo_data_action, from: :await_userTo_data do
          transitions if: -> { text_mes?(T_cancel[$lg]) }      , after: :cancel          , to: :start # "Отмена"
          transitions if: -> {user_shared? &&  bot_has_userTo?}, after: :run_to_userTo   , to: :userTo            # userTo    найден из своего списка пользователей
          transitions if: -> {user_shared? && !bot_has_userTo?}, after: :userTo_not_found, to: :await_userTo_data # userTo не найден из своего списка пользователей
          transitions if: -> {text_mes? && !bot_has_userTo?}   , after: :userTo_not_found, to: :await_userTo_data # userTo не найден из id || username
          transitions if: -> {text_mes? && bot_has_userTo?}    , after: :run_to_userTo   , to: :userTo # userTo    найден из id || username
        end
      end
    end
  end
  
