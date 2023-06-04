# class StateMachine
#   include AASM

#   # aasm whiny_transitions: false

#   aasm do

#     before_all_events   :log_before
#     after_all_events    :log_after
#     error_on_all_events :log_error


#     state :start
#   end


#   def income_message
#     if data?
#       "data = #{$mes.data}"
#     elsif text_mes?
#       "text = #{$mes.text}"
#     end
#   end
#   def log_before
#     user = $user || $mod
#     $logger.info("BEFORE ; user_id = #{user.id} ; from_state = #{aasm.current_state} ; '#{income_message}'")
#   end

#   def log_after
#     user = $user || $mod
#     $logger.info("AFTER  ; user_id = #{user.id} ; new_state  = #{aasm.current_state}")
#   end

#   def log_error(exception)
#     user = $user || $mod
#         fail
#     $logger.error("ERR ; user_id = #{user.id} #{exception}")
#   end
# end


class StateMachine
  class_eval do
    include AASM
    aasm do
        state :start
  
        event :start_action, from: :start do
          # /start
          transitions if: -> { text_mes?('/start') },         after: :to_start,      to: :start
          # 🔎Найти пользователя🔎
          transitions if: -> { text_mes?(T_find_user[$lg]) }, after: :find_userTo,   to: :await_userTo_data
          # 🤝Сделки🤝
          transitions if: -> { text_mes?(T_deals[$lg]) },     after: :to_deals_menu, to: :deals_menu
          # 👨‍💼Профиль👨‍💼
          transitions if: -> { text_mes?(T_profile[$lg]) &&  empty_wallet? },   after: :empty_wallet,  to: :start
          transitions if: -> { text_mes?(T_profile[$lg]) && !empty_wallet? },   after: :view_profile,  to: :profile
        end
      end
    end
end
  
# seva - 6016837864


# text нажата "Найти пользователя"
def find_userTo
  send_message(
    B_await_username_or_id[$lg],
    RM_cancel_to_start.call
  )
end

def to_deals_menu
  send_message(B_choose_action[$lg], RM_deals_menu.call)
end