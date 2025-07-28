# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/22_monkey_market')

class MonkeyMarketTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(MonkeyMarket)) }
  def described_class = MonkeyMarket

  sig { returns(String) }
  def input = <<~INPUT
    1
    10
    100
    2024
  INPUT

  sig { void }
  def test_part1
    assert_equal 37_327_623, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 23, described_class.new("1\n2\n3\n2024").part2
  end
end
