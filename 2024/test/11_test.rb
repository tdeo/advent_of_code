# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/11_plutonian_pebbles')

class PlutonianPebblesTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(PlutonianPebbles)) }
  def described_class = PlutonianPebbles

  sig { returns(String) }
  def input = <<~INPUT
    0 1 10 99 999
  INPUT

  sig { void }
  def test_part1_short
    assert_equal 22, described_class.new('125 17').part1(6)
  end

  sig { void }
  def test_part1
    assert_equal 55_312, described_class.new('125 17').part1
  end
end
