require 'minitest/autorun'
require 'nebrija' 

MOCKS_DIR = "#{File.expand_path(File.dirname(__FILE__))}/mocks"

class TestMockedParserBasic < Minitest::Test

  def test_error_basic
    assert_equal FileRae.new.search("#{MOCKS_DIR}/error.html")[:status] 
  end
  
  def test_single_basic
    assert !FileRae.new.search("#{MOCKS_DIR}/single.html")[:response][:data].nil?
  end

  def test_multiple_basic
    assert FileRae.new.search("#{MOCKS_DIR}/multiple.html")[:reponse].length == 2
  end
end

class TestMockedParserContent < Minitest::Test
 
  def test_single_basic
    assert FileRae.new.search("#{MOCKS_DIR}/single.html")[:response].length > 20
  end

  def test_multiple_basic
    assert FileRae.new.search("#{MOCKS_DIR}/multiple.html")[:response][0][:word] == 'bancar' 
    assert FileRae.new.search("#{MOCKS_DIR}/multiple.html")[:response][1][:word] == 'banco'  
  end
end


class TestMockedParserBasic < Minitest::Test

  def test_single_basic_id
    assert !HTTPRae.new.search('MHpGWYJ6YDXX2bw9Ghwm')[:response].nil?
  end

  def test_error_basic
    assert HTTPRae.new.search('jddhfgsd')[:status] == 'error'
  end
  
  def test_single_basic
    assert !HTTPRae.new.search('a')[:response].nil?
  end

  def test_multiple_basic
    assert HTTPRae.new.search('banco')[:response].length == 2
  end
end

class TestParserContent < Minitest::Test
  
  def test_single_basic
    assert HTTPRae.new.search('a')[:response].length > 4
  end

  def test_multiple_basic
    assert HTTPRae.new.search('banco')[:response][0][:word] == 'bancar' 
    assert HTTPRae.new.search('banco')[:response][1][:word] == 'banco'  
  end
end
