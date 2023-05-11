class StateMachine
    class_eval do
      include AASM
      aasm do
        state :justification
  
        event :justification_action, from: :justification do

          transitions if: -> { mes_text?(Button.make_a_complaint) }, after: :to_justification , to: :justification
          transitions if: -> { mes_text?(Button.request_status) }  , after: :to_justification , to: :justification
          transitions if: -> { mes_text?(Button.account_status) }  , after: :to_justification , to: :justification
          transitions if: -> { mes_text?('/start') }               , after: :to_justification , to: :justification


          transitions if: ->{ mes_text? }                          ,after: :text_justification, to: :scamer
        end
      end
    end
  end
  
