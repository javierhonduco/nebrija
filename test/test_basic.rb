require 'test/unit'
require 'nebrija' 

MOCKS_DIR = "#{File.expand_path(File.dirname(__FILE__))}/mocks"

class TestMockedParserBasic < Test::Unit::TestCase

  def test_error_basic
    assert_equal FileRae.new.search("#{MOCKS_DIR}/error.html")[:status] 
  end
  
  def test_single_basic
    assert_not_nil FileRae.new.search("#{MOCKS_DIR}/single.html")[:response][:data]
  end

  def test_multiple_basic
    assert FileRae.new.search("#{MOCKS_DIR}/multiple.html")[:reponse].length == 2
  end
end

class TestMockedParserContent < Test::Unit::TestCase
  
  def test_single_basic
    assert FileRae.new.search("#{MOCKS_DIR}/single.html")[:response].length > 20
  end

  def test_multiple_basic
    assert FileRae.new.search("#{MOCKS_DIR}/multiple.html")[:response][0][:word] == 'bancar' 
    assert FileRae.new.search("#{MOCKS_DIR}/multiple.html")[:response][1][:word] == 'banco'  
  end
end


class TestMockedParserBasic < Test::Unit::TestCase

  def test_single_basic_id
    assert_not_nil HTTPRae.new.search('MHpGWYJ6YDXX2bw9Ghwm')[:response]
  end

  def test_error_basic
    assert HTTPRae.new.search('jddhfgsd')[:status] == 'error'
  end
  
  def test_single_basic
    assert_not_nil HTTPRae.new.search('a')[:response]
  end

  def test_multiple_basic
    assert HTTPRae.new.search('banco')[:response].length == 2
  end
end

class TestParserContent < Test::Unit::TestCase
  
  def test_single_basic
    assert HTTPRae.new.search('a')[:response].length > 4
  end

  def test_multiple_basic
    assert HTTPRae.new.search('banco')[:response][0][:word] == 'bancar' 
    assert HTTPRae.new.search('banco')[:response][1][:word] == 'banco'  
  end
end
