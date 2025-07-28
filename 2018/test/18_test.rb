# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_settlersof_the_north_pole')

class SettlersofTheNorthPoleTest < Minitest::Test
  def described_class = SettlersofTheNorthPole

  def test_part1
    assert_equal 1147, described_class.new('.#.#...|#.
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
