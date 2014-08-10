require 'test_helper'

class TestRae < Minitest::Test

  def test_error_basic
    stub_request(:post, "#{Rae::SEARCH_URL}?val=wadus").
      to_return(:status => 200, :body => mock('error'), :headers => {})

    search = Rae.new.search('wadus')
    assert_equal search[:status], 'error'
  end

  def test_single_basic
    stub_request(:post, "#{Rae::SEARCH_URL}?val=amor").
      to_return(:status => 200, :body => mock('single'), :headers => {})

    search = Rae.new.search('amor')
    assert_equal 'success', search[:status]
    assert_equal 'single', search[:type]

    first_word = search[:response].first
    assert_equal 'Amor.', first_word[:word]
  end

  def test_multiple_basic
    stub_request(:post, "#{Rae::SEARCH_URL}?val=banco").
      to_return(:status => 200, :body => mock('multiple'), :headers => {})

    search = Rae.new.search('banco')
    assert_equal 'success', search[:status]
    assert_equal 'multiple', search[:type]
    assert_equal 2, search[:response].length
    assert_equal 'bancar', search[:response][0][:word]
    assert_equal 'banco', search[:response][1][:word]
  end

  private

  def mock(mock_name)
    File.read("#{File.expand_path(File.dirname(__FILE__))}/mocks/#{mock_name}.html")
  end
end
