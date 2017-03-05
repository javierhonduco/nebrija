require 'test_helper'

class TestRae < Minitest::Test
  def setup
    WebMock.disable! if ENV['NO_MOCK']
  end

  def test_cli_basic
    word = 'amor'
    stub(word, :single)

    out, = capture_io do
      Nebrija.cli(word)
    end

    assert_match mock(:cli_output).gsub(/\s+/, ''), out.gsub(/\s+/, '')
  end

  def test_error_basic
    word = 'wadus'
    stub(word, :error)

    search = Rae.search('wadus')
    assert_equal search[:status], 'error'
  end

  def test_single_basic
    word = 'amor'
    stub(word, :single)

    search = Rae.search(word)
    assert_equal 'success', search[:status]
    assert_equal 'single', search[:type]

    first_word = search[:response][:word]
    assert_equal 'Amor', first_word
  end

  def test_multiple_basic
    word = 'banco'
    stub(word, :multiple)

    search = Rae.search(word)
    assert_equal 'success', search[:status]
    assert_equal 'multiple', search[:type]
    assert_equal 4, search[:response].length
    assert_equal 'banco azul.', search[:response][:other_meanings][0][:expression]
    assert_equal 'banco central.', search[:response][:other_meanings][1][:expression]
  end

  def test_typeahead
    word = 'amor'

    stub_request(:get, "#{Rae::TYPEAHEAD_URL}&q=#{word}")
      .to_return(status: 200, body: mock(:typeahead))

    search = Rae.typeahead(word)
    assert_equal 10, search.length
    assert_equal ['amor', 'amoragar', 'amoral', 'amoralidad', 'amoralismo', 'amor al uso', 'amoratada', 'amoratado', 'amoratar', 'amoratarse'], search
  end

  def test_empty_typeahead
    word = 'hiomglol'

    stub_request(:get, "#{Rae::TYPEAHEAD_URL}&q=#{word}")
      .to_return(status: 200, body: mock(:typeahead_empty))

    search = Rae.typeahead(word)
    assert_equal 0, search.length
  end


  private

  def stub(word, mock_name)
    stub_request(:post, "#{Rae::SEARCH_URL}?w=#{word}")
      .to_return(status: 200, body: mock(mock_name))
  end

  def mock(mock_name)
    File.read("#{File.expand_path(File.dirname(__FILE__))}/mocks/#{mock_name}")
  end
end
