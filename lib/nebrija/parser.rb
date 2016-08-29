require 'nokogiri'

class Parser
  def initialize(rae_data)
    @doc = Nokogiri::HTML(rae_data)
  end

  def parse
    if valid?
      {
        status: 'success',
        type: single? ? 'single' : 'multiple',
        response: parse_single
      }
    else
      {
        status: 'error',
        message: 'Word/id does not exist. Sorry.'
      }
    end
  end

  private

  def parse_single
    response = {
      core_meanings: [],
      other_meanings: []
    }

    response[:word] = @doc.css('header')
                          .inner_text.sub('.', '')
                          .capitalize!

    @doc.css('body > div > article > p').each_with_index do |entry, index|
      if index.zero?
        # Parsing etymology
        response[:etymology] = entry.inner_text
      elsif entry['class'] =~ /j[0-9]*/
        # Parsing first meaning
        response[:core_meanings] << metadata(entry.inner_text)
      elsif entry['class'] == 'm' || entry['class'] =~ /k[0-9]*/
        # Parsing other meanings
        #   k: expression with 1 element
        #   m: is the meaning with >= elements
        type = (:meaning if entry['class'] == 'm') || :expression
        response[:other_meanings] << [type, entry.inner_text]
      end
    end

    clean! response
  end

  def clean!(response)
    parsed_meanings = []
    state = :EXPR
    temp = nil

    response[:other_meanings].each do |type, text|
      state = :EXPR if type == :expression
      if state == :EXPR
        parsed_meanings << temp unless temp.nil?
        temp = {
          expression: text,
          meanings: []
        }
        state = :MEAN
      elsif state == :MEAN
        temp[:meanings] << metadata(text)
      end
    end
    response[:other_meanings] = parsed_meanings

    response
  end

  def single?
    @doc.css('article').length == 1
  end

  def valid?
    !@doc.css('article').length.zero? # delete_pending?
  end

  def metadata(text)
    # TODO
    # The idea would be to split the text in metadata
    # and real text. It's seems quite tricky.
    {
      meaning: text,
      meta: nil
    }
  end

  def delete_pending?
    # TODO(Check how does it work in the new api)
    raise NotImplementedError
  end
end
