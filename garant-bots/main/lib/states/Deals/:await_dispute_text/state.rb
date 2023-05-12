class StateMachine
    class_eval do
      include AASM
      aasm do
        state :await_disput_text
  
        event :await_disput_text_action, from: :await_disput_text do
          transitions if: -> { text_mes?(T_cancel[$lg]) }, after: :to_deals_menu, to: :deals_menu # "Отмена" создания спора
          transitions if: -> { text_mes? }, after: :create_dispute, to: :deals_menu # создание спора
        end
      end
    end
  end
  
