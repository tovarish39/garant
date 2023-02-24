File.open("#{__dir__}/../tmp/pids.txt", 'a') {|pids_file| pids_file.puts Process.pid}

while true
  puts 'working mod'
  sleep 5
end