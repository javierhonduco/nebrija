require 'sinatra/base'
require 'json'
require "#{Dir.pwd}/models.rb"
require './rae.rb'
require 'redis'

class App < Sinatra::Base
	# TODO
	# => Use background workers
	# => Code a real web frontend
	# => Check if word exists in RAE
	# => Add persistance layer with Redis as caching
	# => Write some tests
	# => Add auth
	# => Add real indexing stuff
	# => Real debug mode w/ Thread loggin

	redis = Redis.new
	get '/' do
		"<h1 style='font-family: Helvetica;'>Maybe you're looking for /:word</h1>"
	end
	get '/:word' do
		
		response = Model::search params[:word]
		return '<a href="bit.ly/9zib9B">Thx!!</a>' if response.nil?
		content_type :json
		response.to_json
	end
end

