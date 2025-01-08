# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/24_arithmetic_logic_unit')

class ArithmeticLogicUnitTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(ArithmeticLogicUnit)) }
  def described_class = ArithmeticLogicUnit

  sig { returns(String) }
  def input = <<~INPUT
    inp w
    add z w
    mod z 2
    div w 2
    add y w
    mod y 2
    div w 2
    add x w
    mod x 2
    div w 2
    mod w 2
  INPUT

  sig { void }
  def test_part1
    assert_equal 8, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 2, described_class.new(input).part2
  end
end
