class StateMachine
    class_eval do
      include AASM
      aasm do
        state :conditions
  
        event :conditions_action, from: :conditions do
          transitions if: lambda {
                            text_mes?
                          }, after: :to_confirming, to: :confirmation_new_deal # ввод условий сделки
        end
      end
    end
  end
  
