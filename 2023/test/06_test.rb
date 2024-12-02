# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/06_wait_for_it')

class WaitForItTest < Minitest::Spec
  extend T::Sig
  sig { returns(T.class_of(WaitForIt)) }
  def described_class = WaitForIt

  sig { returns(String) }
  def input = <<~INPUT
    Time:      7  15   30
    Distance:  9  40  200
  INPUT

  sig { void }
  def test_part1
    assert_equal 288, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 71_503, described_class.new(input).part2
  end
end
