require_relative '../head/requires'

pid_file_path = "#{ROOT_BOT}/tmp/upload_on_telegraph_pid.txt"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }

require 'faraday'

domain = 'api.filechan.org'

conn = Faraday.new(
    url: "https://#{domain}",
    # headers: {'Content-Type' => 'image/jpg'}
    headers: {'Content-Type' => 'multipart/form-data'}
  )
  
file = File.open('/home/g/Desktop/download.jpeg')

response = conn.post('/upload') do |req|
  req.params['file'] = file
end
puts response.body