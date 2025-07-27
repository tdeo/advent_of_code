# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/03_crossed_wires')

describe CrossedWires2019 do
  before { @k = CrossedWires2019 }

  def test_part1
    assert_equal 6, @k.new("R8,U5,L5,D3
U7,R6,D4,L4").part1
    assert_equal 159, @k.new("R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83").part1
    assert_equal 135, @k.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7").part1
  end

  def test_part2
    assert_equal 30, @k.new("R8,U5,L5,D3
U7,R6,D4,L4").part2
    assert_equal 610, @k.new("R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83").part2
    assert_equal 410, @k.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7").part2
  end
end
