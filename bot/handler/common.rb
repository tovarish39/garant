
def get_userTo # return User || false
  clicked_userTo_id = $mes.data.split('/').last
  last_userTo_id = $user.userTo_id
  return false if last_userTo_id != clicked_userTo_id
  $userTo = User.find(last_userTo_id)
end