# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/08_haunted_wasteland')

class HauntedWastelandTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(HauntedWasteland)) }
  def described_class = HauntedWasteland

  sig { returns(String) }
  def input = <<~INPUT
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
  INPUT

  sig { void }
  def test_part1
    assert_equal 2, described_class.new(input).part1
  end

  sig { void }
  def test_part1_2
    assert_equal 6, described_class.new(<<~INPUT).part1
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    INPUT
  end

  sig { void }
  def test_part2
    assert_equal 6, described_class.new(<<~INPUT).part2
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
    INPUT
  end
end
