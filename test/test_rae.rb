require 'test_helper'

class TestRae < Minitest::Test
  def test_cli_basic
    word = 'amor'
    stub_request(:get, "#{Rae::SEARCH_URL}?w=#{word}")
      .to_return(status: 200, body: mock('single'))

    out, = capture_io do
      Nebrija.cli(word)
    end

    assert_match mock_cli.gsub(/\s+/, ''), out.gsub(/\s+/, '')
  end

  def test_error_basic
    stub_request(:get, "#{Rae::SEARCH_URL}?w=wadus")
      .to_return(status: 200, body: mock('error'))

    search = Rae.new.search('wadus')
    assert_equal search[:status], 'error'
  end

  def test_single_basic
    stub_request(:get, "#{Rae::SEARCH_URL}?w=amor")
      .to_return(status: 200, body: mock('single'))

    search = Rae.new.search('amor')
    assert_equal 'success', search[:status]
    assert_equal 'single', search[:type]

    first_word = search[:response][:word]
    assert_equal 'Amor', first_word
  end

  def test_multiple_basic
    stub_request(:get, "#{Rae::SEARCH_URL}?w=banco")
      .to_return(status: 200, body: mock('multiple'))

    search = Rae.new.search('banco')
    assert_equal 'success', search[:status]
    assert_equal 'multiple', search[:type]
    assert_equal 4, search[:response].length
    assert_equal 'banco azul.', search[:response][:other_meanings][0][:expression]
    assert_equal 'banco central.', search[:response][:other_meanings][1][:expression]
  end

  private

  def mock(mock_name)
    File.read("#{File.expand_path(File.dirname(__FILE__))}/mocks/#{mock_name}.html")
  end

  def mock_cli
    # rubocop:disable LineLength
    'Sentimiento hacia otra persona que naturalmente nos atrae y que, procurando reciprocidad en el deseo de unión, nos completa, alegra y da energía para convivir, comunicarnos y crear
    '
  end
end
