# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/19_linen_layout')

class LinenLayoutTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(LinenLayout)) }
  def described_class = LinenLayout

  sig { returns(String) }
  def input = <<~INPUT
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
  INPUT

  sig { void }
  def test_part1
    assert_equal 6, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 16, described_class.new(input).part2
  end
end
