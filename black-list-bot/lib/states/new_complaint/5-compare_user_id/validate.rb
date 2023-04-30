def forwarted?
    $mes.forward_from.present? 
end

def match?
    scamer = Scamer.find_by(id:$user.cur_scamer_id)
    forwarded_telegram_id = $mes.forward_from.id
    writed_telegram_id = scamer.telegram_id
    forwarded_telegram_id == writed_telegram_id
end