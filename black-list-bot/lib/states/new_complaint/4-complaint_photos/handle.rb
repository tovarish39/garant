def get_and_write_file file
    file_path = file['result']['file_path']
    file_url = "https://api.telegram.org/file/bot#{TOKEN_BOT}/#{file_path}"
    

    scamer = Scamer.find($user.cur_scamer_id)
    dir_path = get_photo_dir_path(scamer)
    Dir.mkdir(dir_path) if !Dir.exist?(dir_path)


    $user.photos_size += 1
    photo_path = "#{dir_path}/#{scamer.photos_size}.jpg"
    open(photo_path, 'wb') do |file|
      file << open(file_url).read
    end
end


def handle_photo
    min_size = 0 # availible 3 variants
    file_id = $mes.photo[min_size].file_id

    file = Get.file(file_id)
    status = write_file(file) if file.present?
    nil if status.nil?

    Send.mes(Text.handle_photo)
end


def notice_photos_size
    Send.mes(Text.more_then_max_photos_size) if less_then_max_photos_size?
    Send.mes(Text.less_then_min_photos_size) if more_then_min_photos_size?        
end 