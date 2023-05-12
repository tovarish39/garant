# frozen_string_literal: true

# def not_found
#   Send.mes(Text.not_found)
# end


def get_userTo_telegram_id
  if    is_user_shared?
    userTo_telegram_id = $mes.user_shared[:user_id].to_s
  elsif mes_text?
    userTo_telegram_id = $mes.text
  end
  userTo_telegram_id
end

def to_verify_user_info
  userTo_telegram_id = get_userTo_telegram_id()

  filling_complait = $user.complaints.find_by(
    status: 'filling',
    telegram_id: userTo_telegram_id
  )

  complaint =  if filling_complait.present?
                  filling_complait
            else
               Complaint.create(
                telegram_id: userTo_telegram_id,
                black_list_user_id: $user.id,
                status: 'filling'
              )
            end
  $user.update(cur_complaint_id: complaint.id)
  begin
    data = GetChat.info(userTo_telegram_id)['result']
    complaint.username   = data['username']
    complaint.first_name = data['first_name']
    complaint.last_name  = data['last_name']
  rescue StandardError
  end
  complaint.save

  Send.mes(Text.user_info(complaint), M::Reply.user_info)
end
