# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/18_lavaduct_lagoon')

class LavaductLagoonTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(LavaductLagoon)) }
  def described_class = LavaductLagoon

  sig { returns(String) }
  def input = <<~INPUT
    R 6 (#70c710)
    D 5 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
  INPUT

  sig { void }
  def test_part1
    assert_equal 62, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 952_408_144_115, described_class.new(input).part2
  end
end
