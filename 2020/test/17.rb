# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_conway_cubes')

describe ConwayCubes do
  before { @k = ConwayCubes }

  def test_part1
    assert_equal 112, @k.new('.#.
..#
###').part1
  end

  def test_part2
    assert_equal 848, @k.new('.#.
..#
###').part2
  end
end
