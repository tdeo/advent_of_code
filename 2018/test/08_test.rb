# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/08_memory_maneuver')

class MemoryManeuverTest < Minitest::Test
  def described_class = MemoryManeuver

  def test_part1
    assert_equal 138, described_class.new('2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2').part1
  end

  def test_part2
    assert_equal 66, described_class.new('2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2').part2
  end
end
