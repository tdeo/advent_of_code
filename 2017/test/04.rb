require 'minitest/autorun'
require_relative '../lib/04_high_entropy_passphrases.rb'

class HighEntropyPassphrasesTest < MiniTest::Test
  def test_part1_1
    assert_equal 1, HighEntropyPassphrases.new('aa bb cc dd ee').part1
  end

  def test_part1_2
    assert_equal 0, HighEntropyPassphrases.new('aa bb cc dd aa').part1
  end

  def test_part1_3
    assert_equal 1, HighEntropyPassphrases.new('aa bb cc dd aaa').part1
  end

  def test_part2_1
    assert_equal 1, HighEntropyPassphrases.new('abcde fghij').part2
  end

  def test_part2_2
    assert_equal 0, HighEntropyPassphrases.new('abcde xyz ecdab').part2
  end

  def test_part2_3
    assert_equal 1, HighEntropyPassphrases.new('a ab abc abd abf abj').part2
  end

  def test_part2_4
    assert_equal 1, HighEntropyPassphrases.new('iiii oiii ooii oooi oooo').part2
  end

  def test_part2_5
    assert_equal 0, HighEntropyPassphrases.new('oiii ioii iioi iiio').part2
  end
end
