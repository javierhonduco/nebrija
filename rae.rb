require './parser.rb'
require 'httparty'


class Rae

  SEARCH_URL = 'http://lema.rae.es/drae/srv/search?val='

  def initialize
    
  end

  def search(word)
    raise 'NotImplemtedError'
  end
end


class FileRae < Rae
  
  def initialize
    
  end

  def search(file)
    html = IO.read("#{file}.html")
    Parser.new(html).parse
  end
end

class HttpRae < Rae

  def initialize
    
  end

  def search(word)
    html = HTTParty.get("#{SEARCH_URL}#{word}").body
    Parser.new(html).parse
  end
end


puts FileRae.new.search('error')