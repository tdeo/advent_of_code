# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_planetof_discord')

class PlanetofDiscordTest < Minitest::Test
  def described_class = PlanetofDiscord

  def test_part1
    assert_equal 2_129_920, described_class.new('....#
#..#.
#..##
..#..
#....').part1
  end

  def test_part2
    assert_equal 99, described_class.new('....#
#..#.
#.?##
..#..
#....').part2(10)
  end
end
