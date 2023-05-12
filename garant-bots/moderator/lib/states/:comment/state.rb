class StateMachine
    class_eval do
      include AASM
      aasm do
        state :comment
  
        event :comment_action, from: :comment do
          transitions if: -> {text_mes?}, after: :finishing_dispute,   to: :moderate
        end
      end
    end
  end
  
