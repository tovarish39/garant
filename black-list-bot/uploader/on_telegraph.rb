pid_file_path = "#{ROOT_BOT}/tmp/upload_on_tmp_pid.txt"
File.delete(pid_file_path) if File.exist?(pid_file_path)
File.open(pid_file_path, 'a') { |pid_file| pid_file.puts Process.pid }