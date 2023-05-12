class StateMachine
    class_eval do
      include AASM
      aasm do
        state :userTo
  
        event :userTo_action, from: :userTo do
          ## UserToActions
          transitions if: -> {data?(/Comments/) &&  has_comments?}, after: :view_comments            , to: :userTo # "Отзывы"
          transitions if: -> {data?(/Comments/) && !has_comments?}, after: :no_comments              , to: :userTo # "Отзывы"
          transitions if: -> {data?(/Disputes/)                  }, after: :view_type_of_disputes    , to: :userTo # "Комментарии"
          transitions if: -> {data?(/Offer_deal/)                }, after: :choose_role              , to: :userTo # "Предложить сделку"
          ## Comments TypeOfDisputes Role CurrencyTypes
          transitions if: -> { data?(/Back_to userTo_actions/)   }, after: :to_userTo_from_back      , to: :userTo # "Назад"
          ## TypeOfDisputes
          transitions if: -> {data?(/Won_disputes/)              }, after: :disputes_won             , to: :userTo # "Выйграл споров"
          transitions if: -> {data?(/Lost_disputes/)             }, after: :disputes_lost            , to: :userTo # "Проиграл споров"
          ## WonDisputes LostDisputes
          transitions if: -> { data?(/Back_to TypeOfDisputes/)   }, after: :back_to_type_of_disputes , to: :userTo # "Назад"
          ## Role
          transitions if: -> {data?(/I`m custumer/)              }, after: :choose_type_of_currencies, to: :userTo # "Я покупатель"
          transitions if: -> {data?(/I`m seller/)                }, after: :choose_type_of_currencies, to: :userTo # "Я продавец"
          ## CurrencyTypes
          transitions if: -> {data?(/Criptocurrencies/)          }, after: :choose_specific_currency , to: :userTo # "Криптовалюта"
          transitions if: -> {data?(/Another/)                   }                                   , to: :userTo # ещё не сделано
          ## Currencies
          transitions if: -> {data?(/back_to CurrencyTypes/)     }, after: :back_to_CurrencyTypes    , to: :userTo # "Назад"
          transitions if: -> {data?(/Currency/)                  }, after: :choose_amount            , to: :currency_amount # Выбор определённой валюты
        end
      end
    end
  end
  
