require 'nokogiri'

class Parser

  META_REGEX = /^([a-zA-Z]{1,4}+\.[ ]{1,2})+/

  def initialize(rae_data, word)
    @doc = Nokogiri::HTML(rae_data
                      .gsub(/\n+/, '')
                      .gsub(/\s{2,}+/, ' '))
  end

  def parse
    if valid?
      {
        :status => 'success',
        :type => single? ? 'single' : 'multiple',
        :response => single? ? parse_single : parse_multiple
      }
    else
      {
        :status => 'error',
        :message => 'Word/id does not exist. Sorry.'
      }
    end
  end

  private

  def single?
    @doc.css('body > ul').length.zero?
  end

  def parse_single
    single_data = []
    state = :entry # TODO. Improve FSM syntax.
    index = -1 # HACK(javierhonduco)

    @doc.css('body > div > p').each do |entry|
      if entry['class'] == 'p' and state == :entry
        word = entry.css('span').inner_text
        word = '=>' if word == ''
        single_data << {
          :word => word.strip.capitalize,
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
        } if !text.nil? and text != '' and index >= 0
        state = :definitions
      end
      state = :entry
    end

    single_data
  end

  def parse_multiple
    @doc.css('body > ul > li > a').map do |word|
      {
        :word => word.css('span').first.inner_text,
        :id => word['href'].gsub(/search\?id=/, '')
      }
    end
  end

  def valid?
    valid_title = (@doc.css('title').inner_text =~/error/).nil?
    valid_body  = (@doc.css('body').inner_text =~/No encontrado/).nil?

    valid_title && valid_body && delete_pending?
  end

  def delete_pending?
    tb_deleted = true
    if !@doc.css('body > div > p').nil? && !@doc.css('body > div > p').first.nil?
      tb_deleted = (@doc.css('body > div > p').first.inner_text =~/suprimido/).nil?
    end
    tb_deleted
  end
end
