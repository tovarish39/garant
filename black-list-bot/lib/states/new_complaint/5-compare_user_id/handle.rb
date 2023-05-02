def nothing
end



def notice_request
    Send.mes(Text.complaint_request_to_moderator)
    to_start    
end

def handle_proof
    scamer = Scamer.find_by(id:$user.cur_scamer_id)
    scamer.is_proofed_by_forwarted_mes = true
    scamer.status = 'request'
    scamer.save
    system("bundle exec ruby #{UPLOAD_ON_TMP_PATH} #{scamer.id} #{$user.id}") 
    
    notice_request
end

def skip_proof
    scamer = Scamer.find_by(id:$user.cur_scamer_id)
    scamer.status = 'request'
    scamer.save
    system("bundle exec ruby #{UPLOAD_ON_TMP_PATH} #{scamer.id} #{$user.id}") 

    notice_request
end