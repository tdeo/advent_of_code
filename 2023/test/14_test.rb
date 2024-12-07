# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/14_parabolic_reflector_dish')

class ParabolicReflectorDishTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(ParabolicReflectorDish)) }
  def described_class = ParabolicReflectorDish

  sig { returns(String) }
  def input = <<~INPUT
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
  INPUT

  sig { void }
  def test_part1
    assert_equal 136, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 64, described_class.new(input).part2
  end
end
