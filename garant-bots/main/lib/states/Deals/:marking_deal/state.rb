class StateMachine
    class_eval do
      include AASM
      aasm do
        state :marking_deal
  
        event :marking_deal_action, from: :marking_deal do
          transitions if: -> { data?(/stars/) }, after: :to_add_comment, to: :add_comment
        end
      end
    end
  end
  
