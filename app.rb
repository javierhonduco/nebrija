require './rae.rb'

puts 'Oh, hai!'
puts
puts HTTPRae.new.search(ARGV[0])
