class StateMachine
    class_eval do
      include AASM
      aasm do
        state :confirmation_new_deal
  
        ## :confirmation_new_deal
        event :confirmation_new_deal_action, from: :confirmation_new_deal do
          transitions if: lambda {
                            data?(/Confirming_new_deal/)
                          }, after: :deal_request, to: :start # создание сделки и отправка на подтверждение seller || custumer
          transitions if: lambda {
                            data?(/Cancel_new_deal/)
                          }, after: :to_userTo_from_back, to: :userTo # "Отмена" сделки (не создание)
        end
      end
    end
  end
  
