require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'

require 'librato-rack'

config = Librato::Rack::Configuration.new
config.user = 'javierhonduco@gmail.com'
config.token = 'e0a75ca66677bf7c4643b7371924022799cb5ca8fe9bc9e6cee3bca7036723ee'

use Librato::Rack, :config => config

Librato.increment 'www.worker.spawned'

configure do
	file = File.new("#{Dir.pwd}/logs/rack.log", 'a+')
  	file.sync = true
  	use Rack::CommonLogger, file
end

run App
