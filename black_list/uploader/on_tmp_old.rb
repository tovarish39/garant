require_relative '../requires'
require 'faraday'
require 'faraday/multipart'
require 'telegram/bot'

complaint_id = ARGV[0]
user_id   = ARGV[1]
complaint = Complaint.find(complaint_id)
photos_dir_path = complaint.photos_dir_path
photo_names = Dir.entries(photos_dir_path).filter {|file| file =~ /.jpg$/}
DOMAINS = %w[
  api.anonfiles.com
  api.filechan.org  
  api.letsupload.cc
]
domain_index = 0

BOT = Telegram::Bot::Client.new(TOKEN_BOT)

def get_photo photo_path
  photo = File.open(photo_path)
  rescue => exception
    BOT.api.send_message(text:"photo_path = #{photo_path}", chat_id:MY_CHAT_ID)
    BOT.api.send_message(text:exception,                    chat_id:MY_CHAT_ID)
    BOT.api.send_message(text:exception.backtrace,          chat_id:MY_CHAT_ID)
    nil
end

def upload_on_tmp photo, domain_index
  conn = Faraday.new("https://#{DOMAINS[0]}") do |f|
    f.request :multipart
    f.response :json
  end
  
  response = conn.post('/upload', {
    'file'=>Faraday::Multipart::FilePart.new(photo, 'text/x-ruby')
  })
  # puts response.body
  status = response.body['status']
  
  if status
    return {url:response.body['data']['file']['url']['full']}
  else
    is_last_index = domain_index == (DOMAINS.size - 1)
    if is_last_index
      raise
    else 
      domain_index += 1
      upload_on_tmp(photo, domain_index)
    end
  end

  rescue => exception
    BOT.api.send_message(text:"response.body = #{response.body}", chat_id:MY_CHAT_ID)
    BOT.api.send_message(text:exception,                          chat_id:MY_CHAT_ID)
    BOT.api.send_message(text:exception.backtrace,                chat_id:MY_CHAT_ID)
end


photo_names.each do |photo_name|
  photo_path = "#{photos_dir_path}/#{photo_name}"
  photo = get_photo(photo_path)

  if photo.present?
    url = upload_on_tmp(photo, domain_index)
    urls = complaint.photo_ulrs_remote_tmp
    complaint.update(photo_ulrs_remote_tmp:urls << url[:url].gsub('\\', ''))
  else next
  end
end

# scamer.update(status:'to_moderator')
system("bundle exec ruby #{UPLOAD_ON_TELEGRAPH_PATH} #{complaint.id} #{user_id}")