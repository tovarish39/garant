class StateMachine
    class_eval do
      include AASM
      aasm do
        state :profile
  
        event :profile_action, from: :profile do
          transitions if: -> { data?('Extract') }, after: :extracting, to: :start
        end
      end
    end
  end
  
