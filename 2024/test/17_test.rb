# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/17_chronospatial_computer')

class ChronospatialComputerTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(ChronospatialComputer)) }
  def described_class = ChronospatialComputer

  sig { returns(String) }
  def input = <<~INPUT
    Register A: 729
    Register B: 0
    Register C: 0

    Program: 0,1,5,4,3,0
  INPUT

  sig { void }
  def test_part1
    assert_equal '4,6,3,5,6,3,5,2,1,0', described_class.new(input).part1
  end

  sig { void }
  def test_part1_2
    assert_equal '0,3,5,4,3,0', described_class.new(<<~INPUT).part1
      Register A: 117440
      Register B: 0
      Register C: 0

      Program: 0,3,5,4,3,0
    INPUT
  end

  sig { void }
  def test_part2
    assert_equal 117_440, described_class.new(<<~INPUT).part2
      Register A: 2024
      Register B: 0
      Register C: 0

      Program: 0,3,5,4,3,0
    INPUT
  end
end
