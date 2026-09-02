# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/21_monkey_math')

class MonkeyMathTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(MonkeyMath)) }
  def described_class = MonkeyMath

  sig { returns(String) }
  def input = <<~INPUT
    root: pppw + sjmn
    dbpl: 5
    cczh: sllz + lgvd
    zczc: 2
    ptdq: humn - dvpt
    dvpt: 3
    lfqf: 4
    humn: 5
    ljgn: 2
    sjmn: drzm * dbpl
    sllz: 4
    pppw: cczh / lfqf
    lgvd: ljgn * ptdq
    drzm: hmdt - zczc
    hmdt: 32
  INPUT

  sig { void }
  def test_part1
    assert_equal 152, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 301, described_class.new(input).part2
  end
end
