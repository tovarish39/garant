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
  

  
def text_mes? compare = nil # сообщение text любое или соответствие сравниваемому
   return nil if $mes.class != Message
   return nil if !$mes.text # для кнопки shared_user
   text = $mes.text
   comparing(text, compare)
end

def data?(compare = nil) # сообщение callback любое или соответствие сравниваемому
  return nil if $mes.class != CallbackQuery
  data = $mes.data
  comparing(data, compare)
end







def empty_wallet? = $user.wallet.empty?




####################################################
# sub





