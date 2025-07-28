# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_marble_mania')

class MarbleManiaTest < Minitest::Test
  def described_class = MarbleMania

  def test_part1_1
    assert_equal 32, described_class.new('9 players; last marble is worth 25 points').part1
  end

  def test_part1_2
    assert_equal 8317, described_class.new('10 players; last marble is worth 1618 points').part1
  end

  def test_part1_3
    assert_equal 146_373, described_class.new('13 players; last marble is worth 7999 points').part1
  end

  def test_part1_4
    assert_equal 2764, described_class.new('17 players; last marble is worth 1104 points').part1
  end

  def test_part1_5
    assert_equal 54_718, described_class.new('21 players; last marble is worth 6111 points').part1
  end

  def test_part1_6
    assert_equal 37_305, described_class.new('30 players; last marble is worth 5807 points').part1
  end
end
