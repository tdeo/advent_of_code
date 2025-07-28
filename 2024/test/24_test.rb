# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/24_crossed_wires')

class CrossedWiresTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(CrossedWires)) }
  def described_class = CrossedWires

  sig { returns(String) }
  def input = <<~INPUT
    x00: 1
    x01: 1
    x02: 1
    y00: 0
    y01: 1
    y02: 0

    x00 AND y00 -> z00
    x01 XOR y01 -> z01
    x02 OR y02 -> z02
  INPUT

  sig { void }
  def test_part1
    assert_equal 4, described_class.new(input).part1
  end
end
