# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/20_race_condition')

class RaceConditionTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(RaceCondition)) }
  def described_class = RaceCondition

  sig { returns(String) }
  def input = <<~INPUT
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
  INPUT

  sig { void }
  def test_part1
    assert_equal 0, described_class.new(input).part1(saves_at_least: 65)
    assert_equal 1, described_class.new(input).part1(saves_at_least: 64)
    assert_equal 4, described_class.new(input).part1(saves_at_least: 21)
    assert_equal 5, described_class.new(input).part1(saves_at_least: 20)
  end

  sig { void }
  def test_part2
    assert_equal 3, described_class.new(input).part2(saves_at_least: 76)
    assert_equal 7, described_class.new(input).part2(saves_at_least: 74)
    assert_equal 29, described_class.new(input).part2(saves_at_least: 72)
  end
end
