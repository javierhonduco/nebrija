require 'nokogiri'

class Parser
  
  META_REGEX = /^([a-zA-Z]{1,4}+\.[ ]{1,2})+/

  def initialize(rae_data, word)
    @doc = Nokogiri::HTML(rae_data
                      .gsub(/[\n]+/, '')
                      .gsub(/[ ]{2,}+/, ' '))
    @word = word
  end

  def parse

    return {:status => 'error', :message => 'Word/id does not exist. Sorry.'} if !valid? 
    perform
  end

  def single?
    @doc.css('body > ul').length.zero?
  end

  private 
  def parse_single
    single_data = []
    state = :entry # TODO. Improve FSM syntax.
    index = -1 # HACK(javierhonduco)

    @doc.css('body > div > p').each do |entry|
      if entry['class'] == 'p' and state == :entry
        word = entry.css('span').inner_text
        word = '=>' if word == ''
        single_data << {
          :word => word.strip.capitalize, # gsub(/~/, @word)
          :meanings => [],
          :etymology  => nil
        }
        index+=1
      else
        text = entry.inner_text.strip.gsub(/[0-9]+\.[ ]/, '')
        if text[0] == '('
          single_data[index][:etymology] = text
          next
        end

        unparsed_meta = text.scan META_REGEX
        text = text.gsub(META_REGEX, '')
        single_data[index][:meanings] << {
          :meaning    => text, 
          :meta       => (unparsed_meta.join.strip if unparsed_meta.join.strip != ''),
        } if !text.nil? and text != ''
        state = :definitions
      end
      state = :entry
    end 
    single_data
  end

  def parse_multiple
    multiple_result = []
    @doc.css('body > ul > li > a').each do |word|
      multiple_result << {
        :word => word.css('span').first.inner_text,
        :id => word['href'].gsub(/search\?id=/, '')
      }
    end 
    multiple_result
  end

  def valid?
    valid_title = (@doc.css('title').inner_text =~/error/).nil?
    valid_body  = (@doc.css('body').inner_text =~/No encontrado/).nil?

    valid_title && valid_body && delete_pending?
  end

  def perform
    response = nil
    if single?
      response = parse_single
    else
      response = parse_multiple
    end
    {
      :status => 'success', 
      :type => if single? then 'single' else 'multiple' end,
      :response => response
    }
  end
  
  def delete_pending?
    (@doc.css('body > p.l').inner_text =~/suprimido/).nil?
  end
end
