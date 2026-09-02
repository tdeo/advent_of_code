# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/20_grove_positioning_system')

class GrovePositioningSystemTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(GrovePositioningSystem)) }
  def described_class = GrovePositioningSystem

  sig { returns(String) }
  def input = <<~INPUT
    1
    2
    -3
    3
    -2
    0
    4
  INPUT

  sig { void }
  def test_part1
    assert_equal 3, described_class.new(input).part1
  end

  sig { void }
  def test_part1_dup
    assert_equal 6, described_class.new(<<~INPUT).part1
      1
      1
      0
      2
      3
      4
      5
    INPUT
  end

  sig { void }
  def test_part2
    assert_equal 1_623_178_306, described_class.new(input).part2
  end
end
