# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/14_regolith_reservoir')

class RegolithReservoirTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(RegolithReservoir)) }
  def described_class = RegolithReservoir

  sig { returns(String) }
  def input = <<~INPUT
    498,4 -> 498,6 -> 496,6
    503,4 -> 502,4 -> 502,9 -> 494,9
  INPUT

  sig { void }
  def test_part1
    assert_equal 24, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 93, described_class.new(input).part2
  end
end
