# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/21_step_counter')

class StepCounterTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(StepCounter)) }
  def described_class = StepCounter

  sig { returns(String) }
  def input = <<~INPUT
    ...........
    .....###.#.
    .###.##..#.
    ..#.#...#..
    ....#.#....
    .##..S####.
    .##..#...#.
    .......##..
    .##.#.####.
    .##..##.##.
    ...........
  INPUT

  sig { void }
  def test_part1
    assert_equal 16, described_class.new(input).part1(6)
  end

  sig { returns(String) }
  def input2 = <<~INPUT
    .................
    ..#..............
    ...##........###.
    .............##..
    ..#....#.#.......
    .......#.........
    ......##.##......
    ...##.#.....#....
    ........S........
    ....#....###.#...
    ......#..#.#.....
    .....#.#..#......
    .#...............
    .#.....#.#....#..
    ...#.........#.#.
    ...........#..#..
    .................
  INPUT

  sig { void }
  def test_part2
    # useful test case found at https://www.reddit.com/r/adventofcode/comments/18o1071/2023_day_21_a_better_example_input_mild_part_2/
    assert_equal 52, described_class.new(input2).part2(7)
    assert_equal 68, described_class.new(input2).part2(8)
    assert_equal 576, described_class.new(input2).part2(25)
    assert_equal 1576, described_class.new(input2).part2(42)
    assert_equal 3068, described_class.new(input2).part2(59)
    assert_equal 5052, described_class.new(input2).part2(76)
    assert_equal 1_185_525_742_508, described_class.new(input2).part2(1_180_148)
  end
end
