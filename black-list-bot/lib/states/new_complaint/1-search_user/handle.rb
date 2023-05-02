# frozen_string_literal: true

# def not_found
#   Send.mes(Text.not_found)
# end

def to_verify_user_info
  if    is_user_shared?
    scamer_telegram_id = $mes.user_shared[:user_id].to_s
  elsif mes_text?
    scamer_telegram_id = $mes.text
  end

  not_complete_the_scamer = $user.scamers.find_by(
    status: 'filling',
    telegram_id: scamer_telegram_id
  )

  scamer =  if not_complete_the_scamer
              not_complete_the_scamer
            else
               Scamer.create(
                telegram_id: scamer_telegram_id,
                black_list_user_id: $user.id,
                status: 'filling'
              )
            end
  $user.update(cur_scamer_id: scamer.id)
  begin
    data = GetChat.info(scamer_telegram_id)['result']
    scamer.username   = data['username']
    scamer.first_name = data['first_name']
    scamer.last_name  = data['last_name']
  rescue StandardError
  end
  scamer.save

  Send.mes(Text.user_info(scamer), M::Reply.user_info)
end
