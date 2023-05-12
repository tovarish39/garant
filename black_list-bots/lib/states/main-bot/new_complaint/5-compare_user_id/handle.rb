def nothing
end


def create_or_update_potential_user_scamer complaint
    potential_scamer = BlackListUser.find_by(telegram_id:complaint.telegram_id)

    if potential_scamer.nil?
        BlackListUser.create(
            telegram_id:complaint.telegram_id,
            username:   complaint.username,
            first_name: complaint.first_name,
            last_name:  complaint.last_name
        ) 
    else
        potential_scamer.username   = complaint.username   if complaint.username.present?
        potential_scamer.first_name = complaint.first_name if complaint.first_name.present?
        potential_scamer.last_name  = complaint.last_name  if complaint.last_name.present?
        potential_scamer.save
    end
end


def notice_request complaint
    Send.mes(Text.complaint_request_to_moderator(complaint))
    to_start    
end

def handle_proof
    complaint = Complaint.find_by(id:$user.cur_complaint_id)
    complaint.update(is_proofed_by_forwarted_mes:true)
    
    notice_request complaint
    system("bundle exec ruby #{UPLOAD_ON_TMP_PATH} #{complaint.id} #{$user.id}") 
    create_or_update_potential_user_scamer(complaint)

end

def skip_proof
    complaint = Complaint.find_by(id:$user.cur_complaint_id)
    
    notice_request complaint
    system("bundle exec ruby #{UPLOAD_ON_TMP_PATH} #{complaint.id} #{$user.id}") 
    create_or_update_potential_user_scamer(complaint)


end