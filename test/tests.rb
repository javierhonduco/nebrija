require 'test/unit'
require '../rae.rb' # TODO: Fix relative requires.

class TestMockedParserBasic < Test::Unit::TestCase

  def test_single_basic_id
  end

  def test_error_basic
    assert_not_nil FileRae.new.search('error.html')[:error] 
  end
  
  def test_single_basic
    assert_not_nil FileRae.new.search('single.html')[:data]
  end

  def test_multiple_basic
    assert FileRae.new.search('multiple.html').length == 2
  end
end

class TestMockedParserContent < Test::Unit::TestCase
  
  def test_single_basic
    assert FileRae.new.search('single.html')[:data].length > 20
  end

  def test_multiple_basic
    assert FileRae.new.search('multiple.html')[0][:word] == 'bancar' 
    assert FileRae.new.search('multiple.html')[1][:word] == 'banco'  
  end
end


class TestMockedParserBasic < Test::Unit::TestCase

  def test_error_basic
    assert_not_nil HTTPRae.new.search('jijiijij12')[:error] 
  end
  
  def test_single_basic
    assert_not_nil HTTPRae.new.search('a')[:data]
  end

  def test_multiple_basic
    assert HTTPRae.new.search('banco').length == 2
  end
end

class TestParserContent < Test::Unit::TestCase
  
  def test_single_basic
    assert HTTPRae.new.search('a')[:data].length > 4
  end

  def test_multiple_basic
    assert HTTPRae.new.search('banco')[0][:word] == 'bancar' 
    assert HTTPRae.new.search('banco')[1][:word] == 'banco'  
  end
end