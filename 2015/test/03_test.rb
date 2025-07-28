# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/03_spherical_houses')

class SphericalHousesTest < Minitest::Test
  def described_class = SphericalHouses

  def test_part1
    assert_equal 2, described_class.new('>').part1
    assert_equal 4, described_class.new('^>v<').part1
    assert_equal 2, described_class.new('^v^v^v^v^v').part1
  end

  def test_part2
    assert_equal 3, described_class.new('^v').part2
    assert_equal 3, described_class.new('^>v<').part2
    assert_equal 11, described_class.new('^v^v^v^v^v').part2
  end
end
