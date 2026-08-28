# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'

require_relative('../lib/18_boiling_boulders')

class BoilingBouldersTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(BoilingBoulders)) }
  def described_class = BoilingBoulders

  sig { returns(String) }
  def input = <<~INPUT
    2,2,2
    1,2,2
    3,2,2
    2,1,2
    2,3,2
    2,2,1
    2,2,3
    2,2,4
    2,2,6
    1,2,5
    3,2,5
    2,1,5
    2,3,5
  INPUT

  sig { void }
  def test_part1
    assert_equal 64, described_class.new(input).part1
  end

  sig { void }
  def test_part2_simple
    assert_equal 30, described_class.new(<<~INPUT).part2
      1,1,0
      1,1,2
      1,0,1
      1,2,1
      0,1,1
      2,1,1
    INPUT
  end

  sig { void }
  def test_part2
    assert_equal 58, described_class.new(input).part2
  end
end
