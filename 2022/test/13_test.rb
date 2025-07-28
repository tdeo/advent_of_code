# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/13_distress_signal')

class DistressSignalTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(DistressSignal)) }
  def described_class = DistressSignal

  sig { returns(String) }
  def input = <<~INPUT
    [1,1,3,1,1]
    [1,1,5,1,1]

    [[1],[2,3,4]]
    [[1],4]

    [9]
    [[8,7,6]]

    [[4,4],4,4]
    [[4,4],4,4,4]

    [7,7,7,7]
    [7,7,7]

    []
    [3]

    [[[]]]
    [[]]

    [1,[2,[3,[4,[5,6,7]]]],8,9]
    [1,[2,[3,[4,[5,6,0]]]],8,9]
  INPUT

  sig { void }
  def test_part1
    assert_equal 13, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 140, described_class.new(input).part2
  end
end
