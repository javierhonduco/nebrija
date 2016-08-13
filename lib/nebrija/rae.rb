require 'cgi'
require 'net/http'

class Rae
  SEARCH_URL    = 'http://dle.rae.es/srv/fetch'.freeze
  # rubocop:disable LineLength
  USER_AGENT    = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'.freeze
  OPEN_TIMEOUT  = 2
  READ_TIMEOUT  = 3

  def search(word)
    Parser.new(query(word), word).parse
  end

  private

  def query(word)
    uri = URI "#{SEARCH_URL}?w=#{CGI.escape(word)}".encode('iso-8859-1')

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.open_timeout = OPEN_TIMEOUT
      http.read_timeout = READ_TIMEOUT

      request = Net::HTTP::Get.new uri
      response = http.request request
      response.body
    end
  end
end
