require 'minitest/autorun'
require_relative('../lib/03_toboggan_trajectory.rb')

describe TobogganTrajectory do
  before { @k = TobogganTrajectory }

  def test_part1
    assert_equal 7, @k.new('..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#').part1
  end

  def test_part2
    assert_equal 336, @k.new('..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#').part2
  end
end
