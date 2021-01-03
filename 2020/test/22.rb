# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/22_crab_combat')

describe CrabCombat do
  before { @k = CrabCombat }

  def test_part1
    assert_equal 306, @k.new(<<~INPUT).part1
      Player 1:
      9
      2
      6
      3
      1

      Player 2:
      5
      8
      4
      7
      10
    INPUT
  end

  def test_part2
    assert_equal 291, @k.new(<<~INPUT).part2
      Player 1:
      9
      2
      6
      3
      1

      Player 2:
      5
      8
      4
      7
      10
    INPUT
  end
end
