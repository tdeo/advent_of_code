# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/23_crab_cups')

class CrabCupsTest < Minitest::Test
  def described_class = CrabCups

  def test_part1_1
    assert_equal '54673289', described_class.new(<<~INPUT).part1(moves: 1)
      389125467
    INPUT
  end

  def test_part1_10
    assert_equal '92658374', described_class.new(<<~INPUT).part1(moves: 10)
      389125467
    INPUT
  end

  def test_part1_100
    assert_equal '67384529', described_class.new(<<~INPUT).part1
      389125467
    INPUT
  end

  def test_part2
    slow_test!

    assert_equal 149_245_887_792, described_class.new(<<~INPUT).part2
      389125467
    INPUT
  end
end
