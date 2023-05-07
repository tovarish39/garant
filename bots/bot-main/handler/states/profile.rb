

def view_profile
  send_message(B_view_wallet.call, IM_extract.call)
end

def empty_wallet
  send_message(B_empty_wallet[$lg])
end

def extracting
  $user.update(wallet: {})
  empty_wallet
  to_start
end
