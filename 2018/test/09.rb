# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_marble_mania')

describe MarbleMania do
  before { @k = MarbleMania }

  def test_part1_1
    assert_equal 32, @k.new('9 players; last marble is worth 25 points').part1
  end

  def test_part1_2
    assert_equal 8317, @k.new('10 players; last marble is worth 1618 points').part1
  end

  def test_part1_3
    assert_equal 146_373, @k.new('13 players; last marble is worth 7999 points').part1
  end

  def test_part1_4
    assert_equal 2764, @k.new('17 players; last marble is worth 1104 points').part1
  end

  def test_part1_5
    assert_equal 54_718, @k.new('21 players; last marble is worth 6111 points').part1
  end

  def test_part1_6
    assert_equal 37_305, @k.new('30 players; last marble is worth 5807 points').part1
  end
end
