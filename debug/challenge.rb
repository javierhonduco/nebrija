require 'typhoeus'

class RAESearch

  SEARCH_URL = 'http://lema.rae.es/drae/srv/search?val='
  CHALLENGE = '42612abd48551544c72ae36bc40f440a:kkmj:QG60Q2v4:1477350835'
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36'

  def query(word)

    response = Typhoeus::Request.post(
      SEARCH_URL + word, 
      cookiefile: 'lovecookies', 
      cookiejar: 'lovecookies', 
      followlocation: true,
      accept_encoding: 'gzip',
      body: {
        'TS014dfc77_cr' => CHALLENGE,
        'TS014dfc77_id' => 3,
        'TS014dfc77_76' => 0,
        'TS014dfc77_md' => 1,
        'TS014dfc77_rf' => 0,
        'TS014dfc77_ct' => 0,
        'TS014dfc77_pd' => 0
      },
      headers: {
        'User-Agent' => USER_AGENT,
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Cache-Control' => 'no-cache',
        'Connection' => 'keep-alive',
        'Referer' => SEARCH_URL + word,
        'Accept-Encoding' => 'gzip,deflate,sdch',
        'Accept-Language' => 'es-ES,es;q=0.8,en;q=0.6',
        'Origin' => 'http://lema.rae.es', 
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Content-Disposition' => 'form-data', 
        'name' => 'control-name'
      }
    )
    response.body
  end
end

puts RAESearch.new.query('a')