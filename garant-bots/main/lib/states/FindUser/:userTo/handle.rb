

########################################################################
def choose_role
    return unless get_userTo_from_new_deal # defining $userTo
  
    $user.update(role: nil)
    edit_message(B_choose_role[$lg], IM_role.call)
  end
  #######################################################################
  
  def write_role
    role = $mes.data.split('/').first
    $user.update(role: role == 'I`m custumer' ? 'I`m custumer' : 'I`m seller')
  end
  
  def choose_type_of_currencies
    return unless get_userTo_from_new_deal # defining $userTo
  
    edit_message(B_currency_types[$lg], IM_currency_types.call)
  
    write_role
  end
  
  def back_to_CurrencyTypes
    return unless get_userTo_from_new_deal # defining $userTo
  
    edit_message(B_currency_types[$lg], IM_currency_types.call)
  end
  
  def choose_specific_currency
    return unless get_userTo_from_new_deal # defining $userTo
  
    edit_message(B_currency_types[$lg], IM_cryptocurrencies.call)
  end
  
  ######################################################################
  def choose_amount
    return unless get_userTo_from_new_deal # defining $userTo
  
    selected_currency = $mes.data.split('/')[1]
  
    $user.update(currency: selected_currency)
    send_message("#{B_push_amount_currency[$lg]} <b>#{selected_currency}</b> ")
  end
  
  #############################################################
  # Disputes #
  
  def view_type_of_disputes
    return unless get_userTo_from_new_deal # defining $userTo
  
    edit_message(B_disputes_by_userTo[$lg], IM_type_of_disputes.call)
  end
  
  def disputes_list(type)
    # delete_pushed()
    texts = []
    texts << B_won_disputes[$lg]  if type == 'wins'
    texts << B_lost_disputes[$lg] if type == 'losts'
    # не доделано
    texts.each_with_index do |text, index|
      send_message(text) if index != texts.size - 1 # промежуточный
      send_message(text, IM_back_to_type_of_disputes.call) if index == texts.size - 1 # последний текст
    end
  end
  
  def disputes_won
    return unless get_userTo_from_new_deal # defining $userTo
  
    disputes_list('wins')
  end
  
  def disputes_lost
    return unless get_userTo_from_new_deal # defining $userTo
  
    disputes_list('losts')
  end
  
  def back_to_type_of_disputes
    return unless get_userTo_from_new_deal # defining $userTo
  
    edit_message(B_disputes_by_userTo[$lg], IM_type_of_disputes.call)
  end
  
  ##########################################
  # Comments
  
  def get_deals_with_comment
    $user.deals.filter(&:comment)
end
  
  def view_comments
    return unless get_userTo_from_new_deal # defining $userTo
  
    deals_with_comment = get_deals_with_comment
  
    deals_with_comment.size.times do |i|
      is_last_index = (deals_with_comment.size - 1) == i
      $deal = deals_with_comment[i]
      $customer = User.find($deal.custumer_id)
      if !is_last_index
        send_message(B_comment.call)
      else
        send_message(B_comment.call, IM_back_to_userTo_actions.call)
      end
    end
  end
  

  def no_comments
    send_message(B_no_comments[$lg])
  end
  
  def to_userTo_from_back
    return unless get_userTo_from_new_deal # defining $userTo
  
    send_message(B_userTo_info.call, IM_offer_deal.call)
  end
  ##############################################################
  