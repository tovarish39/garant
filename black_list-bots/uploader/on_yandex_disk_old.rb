require_relative '../requires'
require 'faraday'
require 'faraday/multipart'
require 'telegram/bot'

def yandex_upload_photo href, photo
    Faraday.put(href, photo.read, 'Content-Type' => 'image/jpeg')
end

def yandex_get_link_for_upload photo_name
    url = 'https://cloud-api.yandex.net/v1/disk/resources/upload'
    headers = {
        'Authorization' => TOKEN_YANDEX_DISK, 
        'Accept'        => APP_JSON
    }
    params = {path:photo_name}
    response = Faraday.get(url, params, headers)
    body = JSON.parse(response.body)
    body['href']
end

def yandex_make_dir(dir_name)
    uri = "https://cloud-api.yandex.net/v1/disk/resources?path=#{dir_name}"
    headers ={
                'Accept'        => APP_JSON,
                'Content-Type'  => APP_JSON,
                'Authorization' => TOKEN_YANDEX_DISK
              
            }  
    Faraday.put(uri, nil, headers)
end

def yandex_get_preview yandex_photo_path

    response = Faraday.get("https://cloud-api.yandex.net/v1/disk/resources?path=#{yandex_photo_path}", nil, {
        'Authorization' => TOKEN_YANDEX_DISK, 
        'Accept'        => APP_JSON
    })
    body = JSON.parse(response.body) 
        puts body.keys
    body['preview']
end

def yandex_publish_photo yandex_photo_path
    puts yandex_photo_path
    url = "https://cloud-api.yandex.net/v1/disk/resources/publish?path=#{yandex_photo_path}"
    headers ={
        'Accept'        => APP_JSON,
        'Content-Type'  => APP_JSON,
        'Authorization' => TOKEN_YANDEX_DISK
      
    } 
    response = Faraday.put(url, nil, headers)
    body = JSON.parse(response.body)
    puts '1111'
    puts body
    puts '111111111111'
end

complaint_id = ARGV[0]
user_id   = ARGV[1]


complaint = Complaint.find(complaint_id)
photos_dir_path = complaint.photos_dir_path
photo_names = Dir.entries(photos_dir_path).filter {|file| file =~ /.jpg$/}

BOT = Telegram::Bot::Client.new(TOKEN_BOT)
APP_JSON = 'application/json'

yandex_common_path = '/for_telegraph'

begin
    photo_names.each do |photo_name|
        photo_path = "#{photos_dir_path}/#{photo_name}"
        photo = File.open(photo_path)
      
      
        if photo.present?
          yandex_complaint_dir_path = "#{yandex_common_path}/complate_id_#{complaint_id}"
          yandex_photo_path =  "#{yandex_complaint_dir_path}/#{photo_name}"
      
          yandex_make_dir(yandex_common_path) # for_telegraph
          yandex_make_dir(yandex_complaint_dir_path) 
      
          href = yandex_get_link_for_upload(yandex_photo_path)
          yandex_upload_photo(href, photo)

          view_link =  yandex_publish_photo(yandex_photo_path)
        #   preview = yandex_get_preview(yandex_photo_path)


          urls = complaint.photo_ulrs_remote_tmp
          complaint.update(photo_ulrs_remote_tmp:urls << view_link)
        else next
        end
      end
      
    #   system("bundle exec ruby #{UPLOAD_ON_TELEGRAPH_PATH} #{complaint.id} #{user_id}")
          
# rescue => exception
#     BOT.api.send_message(text:exception,                          chat_id:MY_CHAT_ID)
#     BOT.api.send_message(text:exception.backtrace,                chat_id:MY_CHAT_ID)
end

    