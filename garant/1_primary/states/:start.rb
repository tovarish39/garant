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

          transitions if: -> { text_mes?(T_help[$lg]) }, to: :start
        end
      end
    end
end
  
# seva - 6016837864


def find_userTo
  Send.mes(
    B_await_username_or_id[$lg],
    RM_cancel_to_start.call
  )
end

def to_deals_menu
  Send.mes(B_choose_action[$lg], M::Reply.deals_menu)
end