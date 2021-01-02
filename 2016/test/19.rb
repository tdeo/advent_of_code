# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/19_an_elephant_named_joseph')

describe AnElephantNamedJoseph do
  before { @k = AnElephantNamedJoseph }

  def test_part1
    assert_equal 3, @k.new('5').part1
  end

  def test_part1_2
    assert_equal 5, @k.new('10').part1
  end

  def test_part1_3
    assert_equal 5, @k.new('6').part1
  end

  def test_part1_4
    assert_equal 1, @k.new('8').part1
  end

  def test_part2_1
    assert_equal 2, @k.new('5').part2
  end

  def test_part2_2
    assert_equal 6486, @k.new('65535').part2
  end

  def test_part2_3
    assert_equal 6487, @k.new('65536').part2
  end

  def test_part2_4
    assert_equal 6488, @k.new('65537').part2
  end

  def test_part2_5
    assert_equal 27, @k.new('27').part2
  end
end
