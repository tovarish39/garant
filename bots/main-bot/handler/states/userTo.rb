########################################################################
def choose_role
  return if !get_userTo_from_new_deal() # defining $userTo

  $user.update(role:nil)
  edit_message(B_choose_role[$lg], IM_role.call)
end
#######################################################################


def write_role
  role = $mes.data.split('/').first
  $user.update(role:(role == 'I`m custumer') ? 'I`m custumer' : 'I`m seller')
end

def choose_type_of_currencies 
  return if !get_userTo_from_new_deal() # defining $userTo
  edit_message(B_currency_types[$lg], IM_currency_types.call)

  write_role()
end

def back_to_CurrencyTypes
  return if !get_userTo_from_new_deal() # defining $userTo
  edit_message(B_currency_types[$lg], IM_currency_types.call)
end

def choose_specific_currency
  return if !get_userTo_from_new_deal() # defining $userTo
  edit_message(B_currency_types[$lg], IM_cryptocurrencies.call)
end

######################################################################
def choose_amount
  return if !get_userTo_from_new_deal() # defining $userTo
  selected_currency = $mes.data.split('/')[1]

  $user.update(currency:selected_currency)
  send_message("#{B_push_amount_currency[$lg]} <b>#{selected_currency}</b> " )
end




#############################################################
# Disputes #

def view_type_of_disputes
  return if !get_userTo_from_new_deal() # defining $userTo

  edit_message(B_disputes_by_userTo[$lg], IM_type_of_disputes.call)
end

def disputes_list wins_losts
  # delete_pushed()
  texts = []
  texts << T_won_disputes[$lg]  if wins_losts == 'wins'
  texts << T_lost_disputes[$lg] if wins_losts == 'losts'
# не доделано
  texts.each_with_index do |text, index|
      send_message(text)                                          if index != texts.size - 1 # промежуточный
      send_message(text, IM_back_to_type_of_disputes.call) if index == texts.size - 1 # последний текст 
  end
end

def disputes_won
  return if !get_userTo_from_new_deal() # defining $userTo

  disputes_list('wins')
end

def disputes_lost
  return if !get_userTo_from_new_deal() # defining $userTo

  disputes_list('losts')
end

def back_to_type_of_disputes
  return if !get_userTo_from_new_deal() # defining $userTo

  edit_message(B_disputes_by_userTo[$lg], IM_type_of_disputes.call)
end

##########################################
# Comments
def view_comments
  return if !get_userTo_from_new_deal() # defining $userTo

  texts = [B_userTo_comments[$lg]]
  # не доделано 
  texts.each_with_index do |text, index|
    edit_message(text)                                 if index != texts.size - 1 # промежуточный       
    edit_message(text, IM_back_to_userTo_actions.call) if index == texts.size - 1 # последний текст 
  end
end

def to_userTo_from_back
  return if !get_userTo_from_new_deal() # defining $userTo

  edit_message(B_userTo_info.call, IM_offer_deal.call)
end
##############################################################
