module ReplyM
end

    RM = ->(keyboard){
        Telegram::Bot::Types::ReplyKeyboardMarkup.new(
            keyboard: keyboard, 
            resize_keyboard: true
            ) 
        }


    RM_start = -> { RM.call([T_find_user[$lg], T_deals[$lg], [T_profile[$lg], T_help[$lg]]]) }
    RM_cancel_to_start = lambda {
      RM.call([
                [{ text: T_select_contact[$lg], request_user: { request_id: 111 } }],
                T_cancel[$lg]
              ])
    }
    # :deals_menu
    RM_deals_menu = -> { RM.call([T_active[$lg], T_requests[$lg], T_disputes[$lg], T_deals_history[$lg], T_back[$lg]]) }
    RM_cancel = -> { RM.call([T_cancel[$lg]]) }