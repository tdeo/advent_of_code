# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/07_bridge_repair')

class BridgeRepairTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(BridgeRepair)) }
  def described_class = BridgeRepair

  sig { returns(String) }
  def input = <<~INPUT
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
  INPUT

  sig { void }
  def test_part1
    assert_equal 3749, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 11_387, described_class.new(input).part2
  end
end
