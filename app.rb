require 'json'
require './rae.rb'

puts 'Oh, hai!'
puts
puts JSON.pretty_generate(HTTPRae.new.search(ARGV[0]))
puts JSON.pretty_generate(FileRae.new.search('mocks/single'))