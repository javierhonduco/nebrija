require 'uri'
require 'typhoeus'

class Rae
  SEARCH_URL = 'http://dle.rae.es/srv/fetch'
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'

  def search(word)
    Parser.new(query(word), word).parse
  end

  private

  def query(word)
    url = URI.escape("#{SEARCH_URL}?w=#{word}".encode('iso-8859-1'))
    headers = {
      'User-Agent' => USER_AGENT,
      'Cookie' => 'TS017111a7=017ccc203c0b977befd5d97f3b75b80f201991f161b0d246f45e53dac0967ac4e4acfd7161'
    }

    response = Typhoeus::Request.get(
      url,
      headers: headers,
      accept_encoding: 'gzip',
    )

    response.body
  end
end
