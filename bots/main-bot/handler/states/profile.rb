def view_profile
    send_message(B_view_wallet[$lg], IM_extract.call)
end

def empty_wallet
    send_message(B_empty_wallet[$lg])
end