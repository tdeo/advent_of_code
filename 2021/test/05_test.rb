# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/05_hydrothermal_venture')

class HydrothermalVentureTest < Minitest::Test
  def described_class = HydrothermalVenture

  def test_part1
    assert_equal 5, described_class.new(<<~INPUT).part1
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    INPUT
  end

  def test_part2
    assert_equal 12, described_class.new(<<~INPUT).part2
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    INPUT
  end
end
