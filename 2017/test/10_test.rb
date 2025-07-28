# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/10_knot')

class KnotTest < Minitest::Test
  def described_class = Knot

  def test_part1
    assert_equal 12, described_class.new('3, 4, 1, 5', 5).part1
  end

  def test_part2_1
    assert_equal 'a2582a3a0e66e6e86e3812dcb672a272', described_class.new('').part2
  end

  def test_part2_2
    assert_equal '33efeb34ea91902bb2f59c9920caa6cd', described_class.new('AoC 2017').part2
  end

  def test_part2_3
    assert_equal '3efbe78a8d82f29979031a4aa0b16a9d', described_class.new('1,2,3').part2
  end

  def test_part2_4
    assert_equal '63960835bcdc130f0b66d7ff4f6a5a8e', described_class.new('1,2,4').part2
  end
end
