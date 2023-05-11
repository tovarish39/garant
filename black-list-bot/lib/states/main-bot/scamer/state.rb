class StateMachine
    class_eval do
      include AASM
      aasm do
        state :scamer
  
        event :scamer_action, from: :scamer do
          transitions if: -> { already_used_justification? }                                        ,after: :justification_already_used ,  to: :scamer

          transitions if: -> { mes_data?("Оспорить_justification") && !already_used_justification? },after: :to_justification         ,  to: :justification

          transitions if: -> { mes_text?() && !already_used_justification? }                        , after: :view_complaints_to_scamer, to: :scamer
        end
      end
    end
  end
  
# при любом действии и  already_push_justification      notify+already_used

# при нажатии кнопки и !already_push_justification      to_justi...
# при любом действии и !already_push_justification      full_notify + button
