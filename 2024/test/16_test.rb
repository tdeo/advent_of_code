# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/16_reindeer_maze')

class ReindeerMazeTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(ReindeerMaze)) }
  def described_class = ReindeerMaze

  sig { returns(String) }
  def input = <<~INPUT
    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############
  INPUT

  sig { returns(String) }
  def input2 = <<~INPUT
    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################
  INPUT

  sig { void }
  def test_part1
    assert_equal 7036, described_class.new(input).part1
    assert_equal 11_048, described_class.new(input2).part1
  end

  sig { void }
  def test_part2
    assert_equal 45, described_class.new(input).part2
    assert_equal 64, described_class.new(input2).part2
  end
end
