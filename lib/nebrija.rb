require 'typhoeus'
require 'uri'
require 'nebrija/parser'

class Rae
  SEARCH_URL = 'http://lema.rae.es/drae/srv/search'

  def search(word)
    Parser.new(query(word), word).parse
  end

  private

  def query(word)
    params = (word.encode('utf-8') =~ /\d/) ? 'id=' : 'val='

    response = Typhoeus::Request.post(
      URI.escape("#{SEARCH_URL}?#{params}#{word}".encode('iso-8859-1')),
      :body => build_body
    )

    response.body
  end

  def build_body
    {
      'TS014dfc77_id' => 3,
      'TS014dfc77_cr' => '42612abd48551544c72ae36bc40f440a%3Akkmj%3AQG60Q2v4%3A1477350835',
      'TS014dfc77_76' => 0,
      'TS014dfc77_86' => 0,
      'TS014dfc77_md' => 1,
      'TS014dfc77_rf' => 0,
      'TS014dfc77_ct' => 0,
      'TS014dfc77_pd' => 0
    }.map {|key, value|
      "#{key}=#{value}"
    }.join('&')
  end
end
