class StateMachine
    class_eval do
      include AASM
      aasm do
        state :compare_user_id
  
        event :compare_user_id_action, from: :compare_user_id do
          transitions if: -> { mes_text?(Button.cancel) }, after: :to_start    , to: :start
          transitions if: -> { mes_text?(Button.skip) }  , after: :skip_proof  , to: :start

          transitions if: -> { forwarted? &&  match? }   , after: :handle_proof, to: :start
          transitions if: -> { forwarted? && !match? }   , after: :nothing     , to: :compare_user_id

        end
      end
    end
  end
  