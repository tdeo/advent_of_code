# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/07_internet')

class InternetTest < Minitest::Test
  def described_class = Internet

  def test_part1_1
    assert_equal 1, described_class.new('abba[mnop]qrst').part1
  end

  def test_part1_2
    assert_equal 0, described_class.new('abcd[bddb]xyyx').part1
  end

  def test_part1_3
    assert_equal 0, described_class.new('aaaa[qwer]tyui').part1
  end

  def test_part1_4
    assert_equal 1, described_class.new('ioxxoj[asdfgh]zxcvbn').part1
  end

  def test_part2_1
    assert_equal 1, described_class.new('aba[bab]xyz').part2
  end

  def test_part2_2
    assert_equal 0, described_class.new('xyx[xyx]xyx').part2
  end

  def test_part2_3
    assert_equal 1, described_class.new('aaa[kek]eke').part2
  end

  def test_part2_4
    assert_equal 1, described_class.new('zazbz[bzb]cdb').part2
  end

  def test_part2_5
    assert_equal 0, described_class.new('aaa[aaa]aaa').part2
  end
end
