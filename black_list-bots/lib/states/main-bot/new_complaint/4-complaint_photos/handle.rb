def write_file file, complaint
    file_path = file['result']['file_path']
    file_url = URI("https://api.telegram.org/file/bot#{TOKEN_BOT}/#{file_path}")
#   puts   file_url
    dir_path = get_photo_dir_path(complaint)
    Dir.mkdir(dir_path) if !Dir.exist?(dir_path)

    complaint.photos_size += 1
    complaint.photos_dir_path = dir_path
    complaint.save

    photo_path = "#{dir_path}/#{complaint.photos_size}.jpg"
    
    photo_data = Net::HTTP.get_response(file_url).body

    File.write(photo_path, photo_data, mode: 'wb')
end

def handle_photo
    min_size = 2 # availible 3 variants (indexes)
    file_id = $mes.photo[min_size].file_id
    file = Get.file(file_id)
    complaint = Complaint.find($user.cur_complaint_id)
    write_file(file, complaint) if file.present?

    Send.mes(Text.handle_photo(complaint.photos_size))
end


def notice_max_photos_size
    Send.mes(Text.notice_max_photos_size)
end 

def notice_min_photos_size
    Send.mes(Text.notice_min_photos_size)
end

def to_compare_user_id
    Send.mes(Text.compare_user_id, M::Reply.compare_user_id)
end