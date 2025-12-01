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

  sig { void }
  def test_part2
    skip('Not implemented')

    assert_equal 12, described_class.new(<<~INPUT).part2(7)
      .......
      .......
      ...S...
      .......
      .......
    INPUT
  end
end
