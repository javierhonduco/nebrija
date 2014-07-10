require 'typhoeus'


class RAESearch

  SEARCH_URL = 'http://lema.rae.es/drae/srv/search?val='
  CHALLENGE = '42612abd48551544c72ae36bc40f440a:kkmj:QG60Q2v4:1477350835'
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36'

  def query(word)

    response = Typhoeus::Request.post(
      "http://lema.rae.es/drae/srv/search?val=#{word}", #
      body: {
              'TS014dfc77_id' => 3,
              'TS014dfc77_cr' => '42612abd48551544c72ae36bc40f440a%3Akkmj%3AQG60Q2v4%3A1477350835',
              'TS014dfc77_76' => 0,
              'TS014dfc77_md' => 1,
              'TS014dfc77_rf' => 0,
              'TS014dfc77_ct' => 0,
              'TS014dfc77_pd' => 0
            }.map {|key, value|
              "#{key}=#{value}"
            }.join('&'))

    
    response.body
  end
end

puts RAESearch.new.query('a')