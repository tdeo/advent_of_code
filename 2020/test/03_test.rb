# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/03_toboggan_trajectory')

class TobogganTrajectoryTest < Minitest::Test
  def described_class = TobogganTrajectory

  def test_part1
    assert_equal 7, described_class.new('..##.......
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
    assert_equal 336, described_class.new('..##.......
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
