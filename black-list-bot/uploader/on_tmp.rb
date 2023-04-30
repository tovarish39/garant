require_relative '../head/requires'
require 'faraday'
require 'faraday/multipart'

pid_file_path = "#{ROOT_BOT}/tmp/upload_on_telegraph_pid.txt"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }




domain = 'api.filechan.org'
file = File.open('/home/g/Desktop/download.jpeg')



conn = Faraday.new("https://#{domain}") do |f|
  f.request :multipart
end

response = conn.post('/upload', {
  'file'=>Faraday::Multipart::FilePart.new(file, 'text/x-ruby')
})
puts response.status