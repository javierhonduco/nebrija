class Rae
# Class to to serve as a  *extremely basic* wrapper to the RAE's webpage
# TODO
# => Support diffs wepages for wome words such as 'casa'
# => Support different meanings for a given word
# => Support * the things!

	require 'nokogiri'
	require 'open-uri'

	attr_reader :url, :encode
	attr_writer :xml
	attr_accessor :store

	def initialize args
		@url = "http://lema.rae.es/drae/srv/search?val=#{args[:word]}"
		@store = []
		@xml = nil
		@encode = args[:encode]
	end

	def fetch
		open url
	end

	def nogokirize
		Nokogiri::HTML fetch
	end

	def withencoding
		self.nogokirize.encoding = 'utf-8' || encode 
		self.nogokirize
	end

	def process
		withencoding.css('p.q').each do |word|
			next if word.nil?	
			
			word.css('span.g').each do |meta|
				@meta =  meta.text 
			end
			word.css('span.b').each do |definition|
				@definition =  definition.text 
			end

			unless @meta.nil? or @definition.nil?
				store.push 	:gender=> @meta.strip, 
							:definition=> @definition.strip
			end
		end
		store
	end

	def jsonize
		require 'json'
		process.to_json
	end
end