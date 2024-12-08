# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/08_resonant_collinearity')

class ResonantCollinearityTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(ResonantCollinearity)) }
  def described_class = ResonantCollinearity

  sig { returns(String) }
  def input = <<~INPUT
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
  INPUT

  sig { void }
  def test_part1
    assert_equal 14, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 34, described_class.new(input).part2
  end
end
