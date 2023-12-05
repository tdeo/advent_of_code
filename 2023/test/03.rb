# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/03_gear_ratios')

class GearRatiosTest < Minitest::Spec
  extend T::Sig
  sig { returns(T.class_of(GearRatios)) }
  def described_class = GearRatios

  sig { returns(String) }
  def input = <<~INPUT
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
  INPUT

  sig { void }
  def test_part1
    assert_equal 4361, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 467_835, described_class.new(input).part2
  end
end
