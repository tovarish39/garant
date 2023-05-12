class StateMachine
    class_eval do
      include AASM
      aasm do
        state :moderate
  
        event :moderate_action, from: :moderate do

          transitions if: -> {text_mes?('/start')}        , after: :view_menu                 , to: :moderate
          transitions if: -> {text_mes?('Открытые споры')}, after: :list_opened_disputes      , to: :moderate
          transitions if: -> {text_mes?('Мои споры')}     , after: :list_my_inProcess_disputes, to: :moderate
          transitions if: -> {text_mes?('История споров')}, after: :list_my_closed_disputes   , to: :moderate

          transitions if: -> {data?(/Accept/)}            , after: :handle_acception          , to: :moderate # модератор принимает спор
          transitions if: -> {data?(/Decision/)}          , after: :handle_decision           , to: :comment # seller_lost || custumer_lost || nonobservance
        end
      end
    end
  end
  
