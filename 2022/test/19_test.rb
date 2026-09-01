# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/19_not_enough_minerals')

class NotEnoughMineralsTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(NotEnoughMinerals)) }
  def described_class = NotEnoughMinerals

  sig { returns(String) }
  def input = <<~INPUT
    Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
    Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
  INPUT

  sig { void }
  def test_part1
    assert_equal 33, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 56 * 62, described_class.new(input).part2
  end
end
