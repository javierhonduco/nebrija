require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'

configure do
	file = File.new("#{Dir.pwd}/logs/rack.log", 'a+')
  	file.sync = true
  	use Rack::CommonLogger, file
end

run App
