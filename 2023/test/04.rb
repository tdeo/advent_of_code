# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/04_scratchcards')

class ScratchcardsTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Scratchcards)) }
  def described_class = Scratchcards

  sig { returns(String) }
  def input = <<~INPUT
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  INPUT

  sig { void }
  def test_part1
    assert_equal 13, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 30, described_class.new(input).part2
  end
end
