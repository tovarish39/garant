
def get_userTo_from_new_deal # return User || false
  clicked_userTo_id = $mes.data.split('/').last
  last_userTo_id = $user.userTo_id
  return false if last_userTo_id != clicked_userTo_id
  $userTo = User.find(last_userTo_id)
end

def get_deal
  deal_id = $mes.data.split('/').last
  Deal.find(deal_id)
end