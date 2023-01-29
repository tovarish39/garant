def view_types_of_disputs
  edit_message(Disputs_by_user[$lang], Disputs_types_markup.call)
end

def disputes_list wins_losts
  delete_pushed()
  texts = []
  texts << Won[$lang]  if wins_losts == 'wins'
  texts << Lost[$lang] if wins_losts == 'losts'

  texts.each_with_index do |text, index|
      send_message(text)                              if index != texts.size - 1 # промежуточный
      send_message(text, Back_to_disputs_markup.call) if index == texts.size - 1 # последний текст 
  end
end

def disputs_won
  disputes_list('wins')
end

def disputs_lost
  disputes_list('losts')
end










  


  

  