require 'minitest/autorun'
require_relative('../lib/24_planetof_discord.rb')

describe PlanetofDiscord do
  before { @k = PlanetofDiscord }

  def test_part1
    assert_equal 2129920, @k.new('....#
#..#.
#..##
..#..
#....').part1
  end

  def test_part2
    assert_equal 99, @k.new('....#
#..#.
#.?##
..#..
#....').part2(10)
  end
end
