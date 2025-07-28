# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/06_fire_hazard')

class FireHazardTest < Minitest::Test
  def described_class = FireHazard

  def test_part1
    assert_equal 998_996, described_class.new('turn on 0,0 through 999,999
toggle 0,0 through 999,0
turn off 499,499 through 500,500').part1
  end

  def test_part2
    assert_equal 2_000_001, described_class.new('turn on 0,0 through 0,0
toggle 0,0 through 999,999').part2
  end
end
