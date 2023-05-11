# frozen_string_literal: true

def notify_complaint_length
    Send.mes(Text.more_then_max_length) if more_then_max_length?
    Send.mes(Text.less_then_min_length) if less_then_min_length?
end

def to_complaint_photos
  complaint = Complaint.find_by(
    id: $user.cur_complaint_id,
    status: 'filling'
  )
  complaint.update(complaint_text: $mes.text)

  dir_path = get_photo_dir_path(complaint)
  FileUtils.rm_rf(dir_path) if Dir.exist?(dir_path)

  complaint.update(photos_size:0)
  Send.mes(Text.complaint_photos, M::Reply.complaint_photos)
end