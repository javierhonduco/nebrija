class Model
	require 'json'
	require 'redis'
	def self.search word
		redis = Redis.new # :$
		inmemoryretrieval = redis.get(word)
		if inmemoryretrieval.nil?
			thread = Thread.new{
				require 'redis' # :$$$$$$
				redis = Redis.new
				redis.set word, Rae.new(:word => word).jsonize
			}
			nil
		else
			JSON.parse(inmemoryretrieval)
		end
	end
end