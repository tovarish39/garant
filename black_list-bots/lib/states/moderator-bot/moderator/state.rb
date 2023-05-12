class StateMachine
    class_eval do
      include AASM
      aasm do
        state :moderator
  
        event :moderator_action, from: :moderator do
          transitions if: -> { mes_text?('/start') }                , after: :greeting_mod           , to: :moderator

          transitions if: -> { mes_text?(Button.active_complaints) }, after: :view_complaints        , to: :moderator

          transitions if: -> { mes_data?(/accept_complaint/) }      , after: :handle_accept_complaint, to: :moderator
          
          transitions if: -> { mes_data?(/reject_complaint/) }      , after: :handle_reject_complaint, to: :explanation
          
          transitions if: -> { mes_data?(/access_justification/) }  , after: :accessing_justification, to: :moderator

          transitions if: -> { mes_data?(/block_user/) }            , after: :blocking_scamer         , to: :moderator

        end
      end
    end
  end
  
