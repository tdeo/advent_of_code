# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/22_sand_slabs')

class SandSlabsTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(SandSlabs)) }
  def described_class = SandSlabs

  sig { returns(String) }
  def input = <<~INPUT
    1,0,1~1,2,1
    0,0,2~2,0,2
    0,2,3~2,2,3
    0,0,4~0,2,4
    2,0,5~2,2,5
    0,1,6~2,1,6
    1,1,8~1,1,9
  INPUT

  sig { void }
  def test_part1
    assert_equal 5, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 7, described_class.new(input).part2
  end
end
