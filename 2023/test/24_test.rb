# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/24_never_tell_me_the_odds')

class NeverTellMeTheOddsTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(NeverTellMeTheOdds)) }
  def described_class = NeverTellMeTheOdds

  sig { returns(String) }
  def input = <<~INPUT
    19, 13, 30 @ -2,  1, -2
    18, 19, 22 @ -1, -1, -2
    20, 25, 34 @ -2, -2, -4
    12, 31, 28 @ -1, -2, -1
    20, 19, 15 @  1, -5, -3
  INPUT

  sig { void }
  def test_part1
    assert_equal 2, described_class.new(input).part1(range: (7..27))
  end

  sig { void }
  def test_part2
    assert_equal 47, described_class.new(input).part2
  end
end
