# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/12_garden_groups')

class GardenGroupsTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(GardenGroups)) }
  def described_class = GardenGroups

  sig { returns(String) }
  def input = <<~INPUT
    AAAA
    BBCD
    BBCC
    EEEC
  INPUT

  sig { void }
  def test_part1
    assert_equal 140, described_class.new(input).part1
  end

  sig { void }
  def test_part1_2
    assert_equal 772, described_class.new(<<~INPUT).part1
      OOOOO
      OXOXO
      OOOOO
      OXOXO
      OOOOO
    INPUT
  end

  sig { void }
  def test_part1_3
    assert_equal 1930, described_class.new(<<~INPUT).part1
      RRRRIICCFF
      RRRRIICCCF
      VVRRRCCFFF
      VVRCCCJFFF
      VVVVCJJCFE
      VVIVCCJJEE
      VVIIICJJEE
      MIIIIIJJEE
      MIIISIJEEE
      MMMISSJEEE
    INPUT
  end

  sig { void }
  def test_part2
    assert_equal 80, described_class.new(input).part2
  end

  sig { void }
  def test_part2_2
    assert_equal 436, described_class.new(<<~INPUT).part2
      OOOOO
      OXOXO
      OOOOO
      OXOXO
      OOOOO
    INPUT
  end

  sig { void }
  def test_part2_3
    assert_equal 236, described_class.new(<<~INPUT).part2
      EEEEE
      EXXXX
      EEEEE
      EXXXX
      EEEEE
    INPUT
  end

  sig { void }
  def test_part2_4
    assert_equal 368, described_class.new(<<~INPUT).part2
      AAAAAA
      AAABBA
      AAABBA
      ABBAAA
      ABBAAA
      AAAAAA
    INPUT
  end
end
