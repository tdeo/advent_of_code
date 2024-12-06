# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/06_guard_gallivant')

class GuardGallivantTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(GuardGallivant)) }
  def described_class = GuardGallivant

  sig { returns(String) }
  def input = <<~INPUT
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
  INPUT

  sig { void }
  def test_part1
    assert_equal 41, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 6, described_class.new(input).part2
  end
end
