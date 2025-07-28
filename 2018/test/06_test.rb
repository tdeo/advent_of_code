# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/06_chronal_coordinates')

class ChronalCoordinatesTest < Minitest::Test
  def described_class = ChronalCoordinates

  def test_part1
    assert_equal 17, described_class.new('1, 1
1, 6
8, 3
3, 4
5, 5
8, 9').part1
  end

  def test_part2
    assert_equal 16, described_class.new('1, 1
1, 6
8, 3
3, 4
5, 5
8, 9').part2(32)
  end
end
