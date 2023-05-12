def forwarted?
    $mes.forward_from.present? 
end

def match?
    complaint = Complaint.find_by(id:$user.cur_complaint_id)
    forwarded_telegram_id = $mes.forward_from.id.to_s
    writed_telegram_id = complaint.telegram_id
    forwarded_telegram_id == writed_telegram_id
end