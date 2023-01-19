def comments
    texts = [Users_comments[$lang]]
  
    texts.each_with_index do |text, index|
      edit_message(text)                           if index != texts.size - 1 # промежуточный       
      edit_message(text, Back_to_user_markup.call($next_mes_id)) if index == texts.size - 1 # последний текст 
    end
end
  
  

  
