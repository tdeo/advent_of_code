# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_extended_polymerization')

class ExtendedPolymerizationTest < Minitest::Test
  def described_class = ExtendedPolymerization
  def input = <<~INPUT
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> CNNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
  INPUT

  def test_part1
    assert_equal 1588, described_class.new(input).part1
  end

  def test_part2
    assert_equal 2_188_189_693_529, described_class.new(input).part2
  end
end
