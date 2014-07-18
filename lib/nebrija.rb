require 'nebrija/parser'
require 'typhoeus'


class Rae

  def search(word)
    Parser.new(query(word), word).parse
  end

  private
  def query(word)
    raise 'NotImplementedError'
  end
end


class FileRae < Rae

  private
  def query(file)
    IO.read(file)
  end
end


class HTTPRae < Rae
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36'
  SEARCH_URL = 'http://lema.rae.es/drae/srv/search?'
  ID_REGEX = /[0-9]/

  private
  def query(word)
    @word = word

    params = 'id=' 
    params = 'val=' if val?

    response = Typhoeus::Request.post(
      "http://lema.rae.es/drae/srv/search?#{params}#{word}",
      body: build_headers
    )
    response.body
  end

  def val?
    (@word =~ ID_REGEX).nil?
  end

  def build_headers
    {
      'TS014dfc77_id' => 3,
      'TS014dfc77_cr' => '42612abd48551544c72ae36bc40f440a%3Akkmj%3AQG60Q2v4%3A1477350835',
      'TS014dfc77_76' => 0,
      'TS014dfc77_md' => 1,
      'TS014dfc77_rf' => 0,
      'TS014dfc77_ct' => 0,
      'TS014dfc77_pd' => 0
    }.map {|key, value|
      "#{key}=#{value}"
    }.join('&')
  end
end
