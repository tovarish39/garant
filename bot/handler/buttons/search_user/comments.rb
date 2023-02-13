def view_comments
  userTo = last_userTo() # return userTo || false
  return if !userTo

  texts = [B_userTo_comments[$lang]]
  # не доделано 
  texts.each_with_index do |text, index|
    edit_message(text)                                         if index != texts.size - 1 # промежуточный       
    edit_message(text, IM_back_to_userTo_actions.call(userTo)) if index == texts.size - 1 # последний текст 
  end
end

def to_userTo_from_back
  userTo = last_userTo()
  return if !userTo

  edit_message(B_userTo_info.call(userTo), IM_offer_deal.call(userTo))
end