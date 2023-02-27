def to_confirming
  $user.update(
    conditions:$mes.text,
# делается после создания сделки 
    # hash_name:get_uniq_hash_name()
  )
  $userTo = User.find($user.userTo_id)


  send_message(B_confirm_deal.call, IM_confirm_deal.call)
end

def get_uniq_hash_name
  hash_names_all = UsedHash.all.map(&:name)
  uniq_hash_name = random_uniq_hash_name(5, hash_names_all)
  UsedHash.create!(name:uniq_hash_name) 
  uniq_hash_name
end

def random_uniq_hash_name length, hash_names_all    
  hash_name = get_hash_name(length)
  uniq_hash_name = !hash_names_all.include?(hash_name)

  return hash_name if uniq_hash_name
  return random_uniq_hash_name(length, hash_names_all)
end

def get_hash_name length
  down_case = ('a'..'z').to_a
  up_case =   ('A'..'Z').to_a
  digits =    ('0'..'9').to_a
  characters = down_case + up_case + digits
  size = characters.size
  hash_name = ''
  length.times {hash_name += characters[rand(size)]}
  hash_name
end