class StateMachine
    class_eval do
      include AASM
      aasm do
        state :deals_menu
  
        event :deals_menu_action, from: :deals_menu do
          ## 'Открыть спор'
          transitions if: lambda {
                            data?(/Open_disput/) && valid_deal_status?
                          }, after: :to_await_disput_text, to: :await_disput_text
          transitions if: lambda {
                            data?(/Open_disput/) && !valid_deal_status?
                          }, after: :invalid_deal_status, to: :deals_menu # "Открыть спор" уже была кем-то нажата
          ## 'Подтвердить'  покупатель подтверждает окончание сделки, средства переводятся продавцу
          transitions if: lambda {
                            data?(/Finish_deal/) && valid_deal_status?
                          }, after: :finishing_deal_by_custumer, to: :marking_deal
          transitions if: lambda {
                            data?(/Finish_deal/) && !valid_deal_status?
                          }, after: :invalid_deal_status, to: :deals_menu # "Открыть спор" уже была кем-то нажата
          ## "Отменить сделку" продавец отменяет сделку, средства переводятся покупателю
          transitions if: lambda {
                            data?(/Cancel_exist_deal/) && valid_deal_status?
                          }, after: :canceled_deal_by_seller, to: :deals_menu
          transitions if: lambda {
                            data?(/Cancel_exist_deal/) && !valid_deal_status?
                          }, after: :invalid_deal_status, to: :deals_menu # "Открыть спор" уже была кем-то нажата
    
          ## 'Активные'
          transitions if: lambda {
                            text_mes?(T_active[$lg]) && !has_active_deals?
                          }, after: :hasnot_active_deals,  to: :deals_menu #  отсутствуют
          transitions if: lambda {
                            text_mes?(T_active[$lg]) && has_active_deals?
                          }, after: :view_active_deals,    to: :deals_menu # присутствуют
          ## 'Запросы'
          transitions if: lambda {
                            text_mes?(T_requests[$lg]) && !has_request_deals?
                          }, after: :hasnot_request_deals, to: :deals_menu #  отсутствуют
          transitions if: lambda {
                            text_mes?(T_requests[$lg]) && has_request_deals?
                          }, after: :view_request_deals, to: :deals_menu # присутствуют
          ## 'Споры'
          transitions if: lambda {
                            text_mes?(T_disputes[$lg]) && !has_dispute_deals?
                          }, after: :hasnot_dispute_deals, to: :deals_menu #  отсутствуют
          transitions if: lambda {
                            text_mes?(T_disputes[$lg]) && has_dispute_deals?
                          }, after: :view_dispute_deals, to: :deals_menu # присутствуют
          ## 'История сделок'
          transitions if: lambda {
                            text_mes?(T_deals_history[$lg]) && !has_history_deals?
                          }, after: :hasnot_history_deals, to: :deals_menu #  отсутствуют
          transitions if: lambda {
                            text_mes?(T_deals_history[$lg]) && has_history_deals?
                          }, after: :view_history_deals, to: :deals_menu # присутствуют
          ## 'Назад'
          transitions if: lambda {
                            text_mes?(T_back[$lg])
                          }, after: :to_start, to: :start # "Назад"
        end
      end
    end
  end
  
