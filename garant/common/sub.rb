

# return User || false
def get_userTo_from_new_deal
  clicked_userTo_id = $mes.data.split('/').last
  last_userTo_id = $user.userTo_id
  return false if last_userTo_id != clicked_userTo_id

  $userTo = User.find(last_userTo_id)
end

def get_deal
  deal_id = $mes.data.split('/').last
  Deal.find(deal_id)
end

def sub_notice user
  puts "#{user.class}.id               => #{user.id.to_s.yellow}"  
  puts "#{user.class}.username         => #{user.username.yellow}" 
  puts "#{user.class}.aasm_state_after => #{user.aasm_state.yellow}"
end

def after_info
  user = $user || $mod
  sub_notice(user)

  puts "$mes.class       => #{$mes.class.to_s.yellow}"
  puts "$mes.data        => #{$mes.data.yellow}" if $mes.class == CallbackQuery 
  puts "$mes.text        => #{$mes.text.yellow if $mes.text.present?}" if $mes.class == Message 
end

def before_info
  puts "aasm_state_before => #{$user.aasm_state.green}" if $user.present?
  puts "aasm_state_before => #{$mod.aasm_state.green}" if $mod.present?
  puts
end