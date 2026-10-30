# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/22_monkey_map')

class MonkeyMapTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(MonkeyMap)) }
  def described_class = MonkeyMap

  sig { returns(String) }
  def input = <<~INPUT
            ...#
            .#..
            #...
            ....
    ...#.......#
    ........#...
    ..#....#....
    ..........#.
            ...#....
            .....#..
            .#......
            ......#.

    10R5L5R10L4R5L5
  INPUT

  sig { void }
  def test_part1
    assert_equal 6032, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 0, described_class.new(input).part2
  end
end
