# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/12_hill_climbing_algorithm')

class HillClimbingAlgorithmTest < Minitest::Spec
  extend T::Sig
  sig { returns(T.class_of(HillClimbingAlgorithm)) }
  def described_class = HillClimbingAlgorithm

  sig { returns(String) }
  def input = <<~INPUT
    Sabqponm
    abcryxxl
    accszExk
    acctuvwj
    abdefghi
  INPUT

  sig { void }
  def test_part1
    assert_equal 31, described_class.new(input).part1
  end

  sig { void }
  def test_part2
    assert_equal 29, described_class.new(input).part2
  end
end
