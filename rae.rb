require './parser.rb'
require 'typhoeus'


class Rae

  def search(word)
    Parser.new(query(word), word).parse
  end

  private
  def query(word)
    raise 'NotImplemetedError'
  end
end


class FileRae < Rae
  BASE_EXTENSION = 'html'

  private
  def query(file)
    IO.read("#{file}.#{BASE_EXTENSION}}")
  end
end


class HTTPRae < Rae
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36'
  SEARCH_URL = 'http://lema.rae.es/drae/srv/search?'

  ID_REGEX = /[A-Z0-9]+[a-z]+/

  private
  def query(word)
    @word = word
    
    params = 'id='
    params = 'val=' if val?

    `curl -s '#{SEARCH_URL}#{params}#{word}' \
    -H 'Pragma: no-cache'  \
    -H 'Origin: http://lema.rae.es' \
    -H 'Accept-Encoding: gzip,deflate,sdch' \
    -H 'Accept-Language: es-ES,es;q=0.8,en;q=0.6' \
    -H 'User-Agent: #{USER_AGENT}' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
    -H 'Cache-Control: no-cache' \
    -H 'Referer: http://lema.rae.es/drae/srv/search?val=#{word}' \
    -H 'Connection: keep-alive' \
    --form 'TS014dfc77_id=3&TS014dfc77_cr=42612abd48551544c72ae36bc40f440a%3Akkmj%3AQG60Q2v4%3A1477350835&TS014dfc77_76=0&TS014dfc77_md=1&TS014dfc77_rf=0&TS014dfc77_ct=0&TS014dfc77_pd=0' \
    --compressed`
  end

  def val?
    (@word =~ ID_REGEX).nil?
  end
   
end