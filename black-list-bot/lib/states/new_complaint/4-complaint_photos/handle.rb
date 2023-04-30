def write_file file, scamer
    file_path = file['result']['file_path']
    file_url = URI("https://api.telegram.org/file/bot#{TOKEN_BOT}/#{file_path}")
  puts   file_url
    dir_path = get_photo_dir_path(scamer)
    Dir.mkdir(dir_path) if !Dir.exist?(dir_path)

    scamer.photos_size += 1
    scamer.save

    photo_path = "#{dir_path}/#{scamer.photos_size}.jpg"
    
    photo_data = Net::HTTP.get_response(file_url).body

    File.write(photo_path, photo_data, mode: 'wb')
end

def handle_photo
    min_size = 0 # availible 3 variants
    file_id = $mes.photo[min_size].file_id
    file = Get.file(file_id)
    scamer = Scamer.find($user.cur_scamer_id)
    write_file(file, scamer) if file.present?

    Send.mes(Text.handle_photo(scamer.photos_size))
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