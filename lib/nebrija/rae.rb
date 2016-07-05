require 'uri'
require 'faraday'

class Rae
  SEARCH_URL = 'http://dle.rae.es/srv/fetch'
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'

  def search(word)
    Parser.new(query(word), word).parse
  end

  private

  def query(word)
    url = URI.escape("#{SEARCH_URL}?w=#{word}".encode('iso-8859-1'))

    response = Faraday.get(url)
    response.body
  end
end
