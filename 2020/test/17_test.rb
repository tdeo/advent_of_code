# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_conway_cubes')

class ConwayCubesTest < Minitest::Test
  def described_class = ConwayCubes

  def test_part1
    assert_equal 112, described_class.new('.#.
..#
###').part1
  end

  def test_part2
    assert_equal 848, described_class.new('.#.
..#
###').part2
  end
end
