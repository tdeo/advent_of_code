# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_settlersof_the_north_pole')

describe SettlersofTheNorthPole do
  before { @k = SettlersofTheNorthPole }

  def test_part1
    assert_equal 1147, @k.new('.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.').part1
  end
end
