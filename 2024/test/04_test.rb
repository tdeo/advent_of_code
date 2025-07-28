# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/04_ceres_search')

class CeresSearchTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(CeresSearch)) }
  def described_class = CeresSearch

  sig { returns(String) }
  def input = <<~INPUT
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
  INPUT

  sig { void }
  def test_part1
    assert_equal 18, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 9, described_class.new(input).part2
  end
end
