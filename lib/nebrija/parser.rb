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
        :type => 'single',
        :response => parse_single
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
    @doc.css('article').length == 1
  end

  def parse_single
    response = {
      :basic_meanings => [],
      :other_meanings => []
    }

    response[:word] = @doc.css('header').inner_text.sub('.', '')

    @doc.css('body > div > article > p').each_with_index do |entry, index|
      if index.zero? # Parsing etymology
        response[:etymology] = entry.inner_text
      elsif entry['class'] =~ /j[0-9]*/
        # Parsing first meaning
        response[:basic_meanings] << metadata(entry.inner_text)
      elsif entry['class'] == 'm' || entry['class'] =~/k[0-9]*/
        # Parsing other meanings
        #   k is the expression with 1 element
        #   m is the meaning with >= elements
        type = (:meaning if entry['class'] == 'm') || :expression
        response[:other_meanings] << [type, entry.inner_text]
      end
    end

    clean! response
  end

  def clean! response
    parsed_meanings = []
    state = :EXPR
    temp = nil

    response[:other_meanings].each do |type, text|
      state = :EXPR if type == :expression
      if state == :EXPR
        unless temp.nil?
          parsed_meanings << temp
        end
        temp = {
          :expression => text,
          :meanings => []
        }
        state = :MEAN
      elsif state == :MEAN
        temp[:meanings] << metadata(text)
      end
    end
    response[:other_meanings] = parsed_meanings

    response
  end

  def metadata text
    # To be implemented
    # The idea would be to split the text in metadata
    # and real text. It's seems quite tricky.
    {
      :meaning => text,
      :meta => nil
    }
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
    !@doc.css('article').length.zero? # delete_pending?
  end

  def delete_pending?
    # TODO: Check
    tb_deleted = true
    if !@doc.css('body > div > p').nil? && !@doc.css('body > div > p').first.nil?
      tb_deleted = (@doc.css('body > div > p').first.inner_text =~/suprimido/).nil?
    end
    tb_deleted
  end
end
