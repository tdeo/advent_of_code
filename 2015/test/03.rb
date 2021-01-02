# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/03_spherical_houses')

describe SphericalHouses do
  before { @k = SphericalHouses }

  def test_part1
    assert_equal 2, @k.new('>').part1
    assert_equal 4, @k.new('^>v<').part1
    assert_equal 2, @k.new('^v^v^v^v^v').part1
  end

  def test_part2
    assert_equal 3, @k.new('^v').part2
    assert_equal 3, @k.new('^>v<').part2
    assert_equal 11, @k.new('^v^v^v^v^v').part2
  end
end
