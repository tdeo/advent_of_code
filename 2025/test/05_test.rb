# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/05_cafeteria')

class CafeteriaTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Cafeteria)) }
  def described_class = Cafeteria

  sig { returns(String) }
  def input = <<~INPUT
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
  INPUT

  sig { void }
  def test_part1
    assert_equal 3, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 14, described_class.new(input).part2
  end
end
