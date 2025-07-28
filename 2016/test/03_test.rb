# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/03_squares')

class SquaresTest < Minitest::Test
  def described_class = Squares

  def test_part1_1
    assert_equal 0, described_class.new('5 10 25').part1
  end

  def test_part1_2
    assert_equal 1, described_class.new('15 15 25').part1
  end

  def test_part1_3
    assert_equal 0, described_class.new('5 10 15').part1
  end

  def test_part1_4
    assert_equal 0, described_class.new('15 10 5').part1
  end

  def test_part1_5
    assert_equal 0, described_class.new('5 10 15').part1
  end

  def test_part2_1
    assert_equal 6, described_class.new('101 301 501
102 302 502
103 303 503
701 401 601
702 402 602
703 403 603').part2
  end

  def test_part2_2
    assert_equal 2, described_class.new('5 5 5
10 10 10
25 14 12').part2
  end
end
