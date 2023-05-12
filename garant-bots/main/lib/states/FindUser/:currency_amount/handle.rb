

###################################
def choose_conditions
    $user.update(amount: $mes.text)
    send_message(B_push_conditions[$lg])
  end
  
  def amount_invalid
    send_message(B_invalid_amount[$lg])
  end
  