# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/17_reservoir_research')

class ReservoirResearchTest < Minitest::Test
  def described_class = ReservoirResearch

  def test_part1
    assert_equal 57, described_class.new('x=495, y=2..7
y=7, x=495..501
x=501, y=3..7
x=498, y=2..4
x=506, y=1..2
x=498, y=10..13
x=504, y=10..13
y=13, x=498..504').part1
  end

  def test_part2
    assert_equal 29, described_class.new('x=495, y=2..7
y=7, x=495..501
x=501, y=3..7
x=498, y=2..4
x=506, y=1..2
x=498, y=10..13
x=504, y=10..13
y=13, x=498..504').part2
  end
end
