def disputs
  edit_message(Disputs_by_user[$lang], Disputs_markup.call($next_mes_id))
end

def disputes_list wins_losts
  delete_pushed()
  texts = []
  texts << Won[$lang]  if wins_losts == 'wins'
  texts << Lost[$lang] if wins_losts == 'losts'

  texts.each_with_index do |text, index|
      send_message(text)                              if index != texts.size - 1 # промежуточный
      send_message(text, Back_to_disputs_markup.call($next_mes_id)) if index == texts.size - 1 # последний текст 
  end
end

def wins
  disputes_list('wins')
end

def losts
  disputes_list('losts')
end










  


  
  # def currency_to_amount
  #   selected_currency_to_deal = $mes.data.split('/')[1]
  #   earlier_user()
  #   $user.update(currency_to_deal:selected_currency_to_deal)
  
  #   $bot.send_message(chat_id: $mes.chat.id, text:"#{Push_amount_currency[$lang]} #{selected_currency_to_deal}", reply_markup:Push_amount_markup.call)
  # end
  
  # def try_write_amount_currency
    
  # end
  