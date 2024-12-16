# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/13_claw_contraption')

class ClawContraptionTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(ClawContraption)) }
  def described_class = ClawContraption

  sig { returns(String) }
  def input = <<~INPUT
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
  INPUT

  sig { void }
  def test_part1
    assert_equal 480, described_class.new(input).part1
  end
end
