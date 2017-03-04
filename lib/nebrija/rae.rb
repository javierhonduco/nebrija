require 'cgi'
require 'net/http'

class Rae
  SEARCH_URL    = 'http://dle.rae.es/srv/fetch'.freeze
  # rubocop:disable LineLength
  USER_AGENT    = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'.freeze
  OPEN_TIMEOUT  = 2
  READ_TIMEOUT  = 3

  def search(word)
    Parser.new(query(word)).parse
  end

  private

  def query(word)
    uri = URI.parse "#{SEARCH_URL}?w=#{CGI.escape(word)}".encode('iso-8859-1')

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.open_timeout = OPEN_TIMEOUT
      http.read_timeout = READ_TIMEOUT

      request = Net::HTTP::Post.new(uri)
      request['User-Agent'] = USER_AGENT
      request.form_data = form_data

      response = http.request request

      response.body
    end
  end

  private
  def form_data
    {
      'TS017111a7_id' => '3',
      'TS017111a7_cr' => '1895c885a17201dca76eb401d01fd59f:jlmn:U9YRi5sw:1485055093',
      'TS017111a7_76' => '0',
      'TS017111a7_86' => '0',
      'TS017111a7_md' => '1',
      'TS017111a7_rf' => '0',
      'TS017111a7_ct' => '0',
      'TS017111a7_pd' => '0',
    }
  end
end
