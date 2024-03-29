class StateMachine
    class_eval do
      include AASM
      aasm do
        state :currency_amount
  
        event :currency_amount_action, from: :currency_amount do
          transitions if: -> {
                            text_mes?(/^\s*\d+([,.]\d+)?\s*$/)
                          }, after: :choose_conditions, to: :conditions #    валидное количество валюты
          transitions unless: -> {
                                text_mes?(/^\s*\d+([,.]\d+)?\s*$/)
                              }, after: :amount_invalid, to: :currency_amount # не валидное количество валюты
        end
      end
    end
  end
  


###################################
def choose_conditions
  $user.update(amount: $mes.text)
  Send.mes(B_push_conditions[$lg])
end

def amount_invalid
  Send.mes(B_invalid_amount[$lg])
end
