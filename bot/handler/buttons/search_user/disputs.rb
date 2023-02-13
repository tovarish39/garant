def view_type_of_disputs
  userTo = last_userTo()
  return if !userTo

  edit_message(B_disputs_by_userTo[$lang], IM_type_of_disputs.call(userTo))
end

def disputes_list wins_losts, userTo
  # delete_pushed()
  texts = []
  texts << T_won_disputs[$lang]  if wins_losts == 'wins'
  texts << T_lost_disputs[$lang] if wins_losts == 'losts'
# не доделано
  texts.each_with_index do |text, index|
      send_message(text)                                          if index != texts.size - 1 # промежуточный
      send_message(text, IM_back_to_type_of_disputs.call(userTo)) if index == texts.size - 1 # последний текст 
  end
end

def disputs_won
  userTo = last_userTo()
  return if !userTo
  
  disputes_list('wins', userTo)
end

def disputs_lost
  userTo = last_userTo()
  return if !userTo

  disputes_list('losts', userTo)
end

def back_to_type_of_disputs
  userTo = last_userTo()
  return if !userTo

  edit_message(B_disputs_by_userTo[$lang], IM_type_of_disputs.call(userTo))
end








  


  

  