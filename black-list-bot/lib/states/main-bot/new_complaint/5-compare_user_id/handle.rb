def nothing
end


def create_or_update_potential_user_scamer scamer
    potential_scamer = BlackListUser.find_by(telegram_id:scamer.telegram_id)

    if potential_scamer.nil?
        BlackListUser.create(
            telegram_id:scamer.telegram_id,
            username:   scamer.username,
            first_name: scamer.first_name,
            last_name:  scamer.last_name
        ) 
    else
        potential_scamer.username   = scamer.username   if scamer.username.present?
        potential_scamer.first_name = scamer.first_name if scamer.first_name.present?
        potential_scamer.last_name  = scamer.last_name  if scamer.last_name.present?
        potential_scamer.save
    end
end


def notice_request scamer
    Send.mes(Text.complaint_request_to_moderator(scamer))
    to_start    
end

def handle_proof
    scamer = Scamer.find_by(id:$user.cur_scamer_id)
    scamer.is_proofed_by_forwarted_mes = true
    scamer.status = 'request'
    scamer.save
    
    notice_request scamer
    system("bundle exec ruby #{UPLOAD_ON_TMP_PATH} #{scamer.id} #{$user.id}") 
    create_or_update_potential_user_scamer(scamer)

end

def skip_proof
    scamer = Scamer.find_by(id:$user.cur_scamer_id)
    scamer.status = 'request'
    scamer.save
    
    notice_request scamer
    system("bundle exec ruby #{UPLOAD_ON_TMP_PATH} #{scamer.id} #{$user.id}") 
    create_or_update_potential_user_scamer(scamer)


end