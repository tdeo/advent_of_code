# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/07_camel_cards')

class CamelCardsTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(CamelCards)) }
  def described_class = CamelCards

  sig { returns(String) }
  def input = <<~INPUT
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
  INPUT

  sig { void }
  def test_part1
    assert_equal 6440, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 5905, described_class.new(input).part2
  end
end
