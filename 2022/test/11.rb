# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/11_monkeyinthe_middle')

class MonkeyintheMiddleTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(MonkeyintheMiddle)) }
  def described_class = MonkeyintheMiddle

  sig { returns(String) }
  def input = <<~INPUT
    Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3

    Monkey 1:
      Starting items: 54, 65, 75, 74
      Operation: new = old + 6
      Test: divisible by 19
        If true: throw to monkey 2
        If false: throw to monkey 0

    Monkey 2:
      Starting items: 79, 60, 97
      Operation: new = old * old
      Test: divisible by 13
        If true: throw to monkey 1
        If false: throw to monkey 3

    Monkey 3:
      Starting items: 74
      Operation: new = old + 3
      Test: divisible by 17
        If true: throw to monkey 0
        If false: throw to monkey 1
  INPUT

  sig { void }
  def test_part1
    assert_equal 10_605, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 2_713_310_158, described_class.new(input).part2
  end
end
