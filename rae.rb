require './parser.rb'
require 'httparty'
require 'open-uri'

user_agent = 'Mozilla/5.0 (Android; Mobile; rv:30.0) Gecko/30.0 Firefox/30.0'



puts open('http://lema.rae.es/drae/srv/search?val=amor').read


