# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/11_cosmic_expansion')

class CosmicExpansionTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(CosmicExpansion)) }
  def described_class = CosmicExpansion

  sig { returns(String) }
  def input = <<~INPUT
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
  INPUT

  sig { void }
  def test_part1
    assert_equal 374, described_class.new(input).part1
  end

  sig { void }
  def test_part2_1
    instance = described_class.new(input)
    instance.instance_variable_set(:@dilation, 10)

    assert_equal 1030, instance.part1
  end

  sig { void }
  def test_part2_2
    instance = described_class.new(input)
    instance.instance_variable_set(:@dilation, 100)

    assert_equal 8410, instance.part1
  end
end
