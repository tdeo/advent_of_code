# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/10_factory')

class FactoryTest < Minitest::Test
  extend T::Sig
  sig { returns(T.class_of(Factory)) }
  def described_class = Factory

  sig { returns(String) }
  def input = <<~INPUT
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
  INPUT

  sig { void }
  def test_part1
    assert_equal 7, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 33, described_class.new(input).part2
  end
end
