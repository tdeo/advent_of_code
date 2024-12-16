# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/14_restroom_redoubt')

class RestroomRedoubtTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(RestroomRedoubt)) }
  def described_class = RestroomRedoubt

  sig { returns(String) }
  def input = <<~INPUT
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
  INPUT

  sig { void }
  def test_part1
    assert_equal 12, described_class.new(input, width: 11, height: 7).part1
  end
end
