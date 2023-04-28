def write_file file
    file_path = file['result']['file_path']
    file_url = "https://api.telegram.org/file/bot#{TOKEN_BOT}/#{file_path}"
    

    scamer = Scamer.find($user.cur_scamer_id)
    dir_path = get_photo_dir_path(scamer)
    puts dir_path
    Dir.mkdir(dir_path) if !Dir.exist?(dir_path)


    scamer.photos_size += 1
    photo_path = "#{dir_path}/#{scamer.photos_size}.jpg"
    open(photo_path, 'wb') do |file|
      file << open(file_url).read
    end
end


# photo_url = 'https://example.com/photo.jpg'
# uri = URI(photo_url)
# photo_data = Net::HTTP.get_response(uri).body
# File.write('photo.jpg', photo_data, mode: 'wb')

# require 'telegram/bot'
# require 'open-uri'

# token = 'YOUR_TELEGRAM_BOT_TOKEN'

# Telegram::Bot::Client.run(token) do |bot|
#   file_id = 'FILE_ID_TO_DOWNLOAD'
#   file = bot.api.get_file(file_id: file_id)
#   file_path = file['result']['file_path']
#   file_url = "https://api.telegram.org/file/bot#{token}/#{file_path}"
#   open('photo.jpg', 'wb') do |file|
#     file << open(file_url).read
#   end
# end


def handle_photo
    min_size = 0 # availible 3 variants
    file_id = $mes.photo[min_size].file_id

    file = Get.file(file_id)
    status = write_file(file) if file.present?
    nil if status.nil?

    Send.mes(Text.handle_photo)
end


def notice_max_photos_size
    Send.mes(Text.notice_max_photos_size)
end 
# Send.mes(Text.less_then_min_photos_size) if more_then_min_photos_size?        