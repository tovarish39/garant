class StateMachine
    class_eval do
      include AASM
      aasm do
        state :explanation
  
        event :explanation_action, from: :explanation do
            transitions if: -> {mes_text?(Button.active_complaints)}, to: :explanation
            transitions if: -> {mes_text?("/start")}                , to: :explanation
            
            transitions if: -> {mes_text?()}, after: :handle_explanation, to: :moderator
        end
      end
    end
  end
  
