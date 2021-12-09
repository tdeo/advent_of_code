# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_smoke_basin')

describe SmokeBasin do
  before { @k = SmokeBasin }

  def test_part1
    assert_equal 15, @k.new(<<~INPUT).part1
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    INPUT
  end

  def test_part2
    assert_equal 1134, @k.new(<<~INPUT).part2
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    INPUT
  end
end
