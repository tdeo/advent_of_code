# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/01_trebuchet')

class TrebuchetTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Trebuchet)) }
  def described_class = Trebuchet

  sig { returns(String) }
  def input = <<~INPUT
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
  INPUT

  sig { void }
  def test_part1
    assert_equal 142, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 281, described_class.new(<<~INPUT).part2
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    INPUT
  end
end
