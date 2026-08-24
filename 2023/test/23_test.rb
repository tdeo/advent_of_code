# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/23_a_long_walk')

class ALongWalkTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(ALongWalk)) }
  def described_class = ALongWalk

  sig { returns(String) }
  def input = <<~INPUT
    #.#####################
    #.......#########...###
    #######.#########.#.###
    ###.....#.>.>.###.#.###
    ###v#####.#v#.###.#.###
    ###.>...#.#.#.....#...#
    ###v###.#.#.#########.#
    ###...#.#.#.......#...#
    #####.#.#.#######.#.###
    #.....#.#.#.......#...#
    #.#####.#.#.#########v#
    #.#...#...#...###...>.#
    #.#.#v#######v###.###v#
    #...#.>.#...>.>.#.###.#
    #####v#.#.###v#.#.###.#
    #.....#...#...#.#.#...#
    #.#########.###.#.#.###
    #...###...#...#...#.###
    ###.###.#.###v#####v###
    #...#...#.#.>.>.#.>.###
    #.###.###.#.###.#.#v###
    #.....###...###...#...#
    #####################.#
  INPUT

  sig { void }
  def test_part1
    assert_equal 94, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 154, described_class.new(input).part2
  end
end
