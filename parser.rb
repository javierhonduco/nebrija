require 'nokogiri'
require 'json'

class Parser

  META_REGEX = /^([a-z]{1,4}+\.[ ])+/

  def initialize(filename)
    @doc = Nokogiri::HTML(IO.read(filename)
                     .gsub!(/[\n]+/, '')
                     .gsub!(/[ ]{1,}+/, ' '))

    puts "This is #{'not ' if single? }a multiple meaning word."
  end

  def parse
    if single?
      data = []
      result = {:id => @doc.css('body > div > a').first['name'].to_i, :data => data}
      # TODO: not used. Delete?
      states = [:definitions, :entry]
      state = :entry
      index = -1 # HACK(javierhonduco)

      @doc.css('body > div > p').each do |entry|
        if entry['class'] == 'p' and state == :entry
          word = entry.css('span').inner_text
          word = 'V:' if word == ''
          data << {:word => word, :meanings => []}
          index+=1
        else
          text = entry.inner_text.strip.gsub(/[0-9]+\.[ ]/, '')
          gender = text[0]
          next if text[0] == '(' # Del latín, Nil.    
          unparsed_meta = text.scan META_REGEX
          text = text.gsub(META_REGEX, '')
          number = text[0]
          data[index][:meanings] << text if !text.nil? and text != ''
          state = :definitions
        end
        state = :entry
      end 
    else
      result = []
      @doc.css('body > ul > li > a').each do |word|
        multiple_result << {
          :word => word.css('span').first.inner_text,
          :href => word['href'].gsub(/search\?id=/, '')
        }
      end 
    end

    result
  end

  private

  def single?
    @doc.css('body > ul').length.zero?
  end
end

# TODO: replace single.html with ARGV[0] ??
result = Parser.new('single.html').parse

puts JSON.pretty_generate(result)
