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
  
