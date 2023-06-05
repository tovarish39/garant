module M
  module Reply
    def self.format_buttons(arr) = arr.map { |line| line.map { |but| { text: but } } }
    RM = -> (buttons) { ReplyKeyboardMarkup.new(keyboard: format_buttons(buttons), resize_keyboard: true)}

    def self.start;RM.call([
      [T_find_user[$lg]], 
      [T_deals[$lg]], 
      [T_profile[$lg], T_help[$lg]]]);end
    
    def self.deals_menu;RM.call([
        [T_active[$lg]], 
        [T_requests[$lg]], 
        [T_disputes[$lg]], 
        [T_deals_history[$lg]], 
        [T_back[$lg]]]);end

    def self.cancel;RM.call([
      [T_cancel[$lg]]]);end

    def self.moderator_menu;RM.call([
      ['Открытые споры'], 
      ['Мои споры'], 
      ['История споров']]);end

  end
end


    
RM_cancel_to_start = -> {
  ReplyKeyboardMarkup.new(
    keyboard: [
      [{ text: T_select_contact[$lg], request_user: { request_id: 111 } }],
      [{ text: T_cancel[$lg] }]
    ], 
    resize_keyboard: true
    )
  }
  


