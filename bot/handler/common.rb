
def get_userTo # return User || false
  clicked_userTo_id = $mes.data.split('/').last
  last_userTo_id = $user.userTo_id
  return false if last_userTo_id != clicked_userTo_id
  $userTo = User.find(last_userTo_id)
end


#############################


def  click_main_button_or_start? =  text? && T_start_actions.include?($mes.text) # любая кнопка из главного меню или '/start'

  def comparing message, compare
    return true if !compare
    with_text  = compare.class == String
    with_regex = compare.class == Regexp 
    return true if with_text  && message == compare
    return true if with_regex && message =~ compare
    false
  end
  
  def user_shared? = $mes.user_shared ? true : false
  
  def text?(compare = nil) # сообщение text любое или соответствие сравниваемому
     return nil if $mes.class != MessageClass
     return nil if !$mes.text # для кнопки shared_user
     text = $mes.text
     comparing(text, compare)
  end
  
  def data?(compare = nil) # сообщение callback любое или соответствие сравниваемому
    return nil if $mes.class != CallbackClass
    data = $mes.data
    comparing(data, compare)
  end








######################################################
def bot_has_userTo?

  if user_shared?() # при поиске из контактов
    telegram_id = $mes.user_shared['user_id']
# puts $mes.user_shared 
# puts telegram_id
    user_by_telegram_id = try_by_telegram_id(telegram_id)
    $userTo = user_by_telegram_id

  elsif   text?()  # при вводе telegram_id или username
    telegram_id = $mes.text.gsub(/\D/, '')
    user_by_telegram_id = try_by_telegram_id(telegram_id) 
    user_by_username    = try_by_username()
    $userTo = user_by_telegram_id || user_by_username
  end
# puts $userTo
  $user.update(userTo_id:$userTo.id) if $userTo
  $userTo # User || nil
end







  def try_by_telegram_id telegram_id 
    found_user = User.find_by(telegram_id:telegram_id)
    if found_user
      return found_user if $user.telegram_id != found_user.telegram_id
    end
    nil
  end
  
  def try_by_username
    id = $mes.text =~ /^id/i
    unless id
      username = $mes.text.gsub(/[@, \s]/, '')
      found_user = User.find_by(username:username)
      if found_user 
        return found_user if $user.username != found_user.username  
      end
    end
    nil
  end