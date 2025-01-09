# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/25_sea_cucumber')

class SeaCucumberTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(SeaCucumber)) }
  def described_class = SeaCucumber

  sig { returns(String) }
  def input = <<~INPUT
    v...>>.vv>
    .vv>>.vv..
    >>.>v>...v
    >>v>>.>.v.
    v>v.vv.v..
    >.>>..v...
    .vv..>.>v.
    v.v..>>v.v
    ....v..v.>
  INPUT

  sig { void }
  def test_part1
    assert_equal 58, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 0, described_class.new(input).part2
  end
end
