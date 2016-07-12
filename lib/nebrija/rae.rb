require 'cgi'
require 'faraday'

class Rae
  SEARCH_URL = 'http://dle.rae.es/srv/fetch'.freeze
  # rubocop:disable LineLength
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'.freeze

  def search(word)
    Parser.new(query(word), word).parse
  end

  private

  def query(word)
    url = "#{SEARCH_URL}?w=#{CGI.escape(word)}".encode('iso-8859-1')

    response = Faraday.get(url)
    response.body
  end
end
