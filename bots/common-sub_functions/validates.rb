## 🤝Сделки🤝
def get_all_deals_for_user
  Deal.where("seller_id = '#{$user.id}' or custumer_id = '#{$user.id}'")
end

def has_active_deals? # status: =~ /payed/ 
  deals = get_all_deals_for_user()
  $active_deals = deals.filter {|deal| deal.status =~ /payed/ }
  $active_deals.empty? ? false : true
end

def has_request_deals? # status: == nil || =~ /accessed/
  all_deals_for_user = get_all_deals_for_user()  
  $request_deals = all_deals_for_user.filter {|deal| deal.status =~ /accessed/ || deal.status.nil? }
  $request_deals.empty? ? false : true
end

def has_dispute_deals? # status: =~ /dispute/
  all_deals_for_user = get_all_deals_for_user()  
  $dispute_deals = all_deals_for_user.filter {|deal| deal.status =~ /dispute/ }
  $dispute_deals.empty? ? false : true
end

def has_history_deals? # statuses: == 'rejected by_seller' || == 'rejected by_custumer' || == 'canceled by_custumer' || == 'finished by_custumer' || == 'finished by_moderator'
  all_deals_for_user = get_all_deals_for_user()  
  $history_deals = all_deals_for_user.filter do |deal| 
    status = deal.status
    status =~ /rejected/ || status =~ /canceled/ || status =~ /finished/ 
  end
  $history_deals.empty? ? false : true
end



def valid_deal_status?
  deal = get_deal()
  return true if deal.status =~ /payed/ 
  false
end

def  click_main_button_or_start? 
  text_mes?() && T_start_actions.include?($mes.text) # любая кнопка из главного меню или '/start'
end
def comparing message, compare
  return true if !compare
  with_text  = compare.class == String
  with_regex = compare.class == Regexp 
  return true if with_text  && message == compare
  return true if with_regex && message =~ compare
  false
end
  
def user_shared? = $mes.user_shared ? true : false
  
def text_mes? compare = nil # сообщение text любое или соответствие сравниваемому
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



def bot_has_userTo?
  if user_shared?() # при поиске из контактов
    telegram_id = $mes.user_shared['user_id']
    user_by_telegram_id = try_by_telegram_id(telegram_id)
    $userTo = user_by_telegram_id

  elsif   text_mes?()  # при вводе telegram_id или username
    telegram_id = $mes.text.gsub(/\D/, '')
    user_by_telegram_id = try_by_telegram_id(telegram_id) 
    user_by_username    = try_by_username()
    $userTo = user_by_telegram_id || user_by_username
  end
  $user.update(userTo_id:$userTo.id) if $userTo
  $userTo # User || nil
end



def empty_wallet? = $user.wallet.empty?




####################################################
# sub





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
