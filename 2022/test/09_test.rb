# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/09_rope_bridge')

class RopeBridgeTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(RopeBridge)) }
  def described_class = RopeBridge

  sig { returns(String) }
  def input = <<~INPUT
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
  INPUT

  sig { void }
  def test_part1
    assert_equal 13, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 1, described_class.new(input).part2
  end

  sig { void }
  def test_part2_2
    assert_equal 36, described_class.new(<<~INPUT).part2
      R 5
      U 8
      L 8
      D 3
      R 17
      D 10
      L 25
      U 20
    INPUT
  end
end
