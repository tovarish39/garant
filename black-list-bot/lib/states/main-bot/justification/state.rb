class StateMachine
    class_eval do
      include AASM
      aasm do
        state :justification
  
        event :justification_action, from: :justification do

          transitions if: -> { mes_text?(Button.make_a_complaint) }, to: :scamer
          transitions if: -> { mes_text?(Button.request_status) }, to: :scamer
          transitions if: -> { mes_text?(Button.account_status) },to: :scamer
          transitions if: -> { mes_text?('/start') }, to: :scamer


          transitions if: ->{ mes_text? },after: :text_justification ,to: :scamer
        end
      end
    end
  end
  
