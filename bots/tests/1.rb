# $LOAD_PATH << './'
# require '2'
puts Dir.home()
# Benchmark.ips do |x|
#   x.report("constant") { HASH2[:foo] }
#   x.report("regular")  { HASH1["foo"]}
# end