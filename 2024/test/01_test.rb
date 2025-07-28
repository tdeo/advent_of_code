# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/01_historian_hysteria')

class HistorianHysteriaTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(HistorianHysteria)) }
  def described_class = HistorianHysteria

  sig { returns(String) }
  def input = <<~INPUT
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
  INPUT

  sig { void }
  def test_part1
    assert_equal 11, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 31, described_class.new(input).part2
  end
end
