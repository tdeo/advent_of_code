# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/10_pipe_maze')

class PipeMazeTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(PipeMaze)) }
  def described_class = PipeMaze

  sig { returns(String) }
  def input = <<~INPUT
    ..F7.
    .FJ|.
    SJ.L7
    |F--J
    LJ...
  INPUT

  sig { void }
  def test_part1
    assert_equal 8, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 10, described_class.new(<<~INPUT).part2
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
    INPUT
  end
end
