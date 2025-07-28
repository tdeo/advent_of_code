# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'minitest/autorun'
require_relative('../lib/15_beacon_exclusion_zone')

class BeaconExclusionZoneTest < Minitest::Test
  extend T::Sig

  sig { returns(T.class_of(BeaconExclusionZone)) }
  def described_class = BeaconExclusionZone

  sig { returns(String) }
  def input = <<~INPUT
    Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    Sensor at x=9, y=16: closest beacon is at x=10, y=16
    Sensor at x=13, y=2: closest beacon is at x=15, y=3
    Sensor at x=12, y=14: closest beacon is at x=10, y=16
    Sensor at x=10, y=20: closest beacon is at x=10, y=16
    Sensor at x=14, y=17: closest beacon is at x=10, y=16
    Sensor at x=8, y=7: closest beacon is at x=2, y=10
    Sensor at x=2, y=0: closest beacon is at x=2, y=10
    Sensor at x=0, y=11: closest beacon is at x=2, y=10
    Sensor at x=20, y=14: closest beacon is at x=25, y=17
    Sensor at x=17, y=20: closest beacon is at x=21, y=22
    Sensor at x=16, y=7: closest beacon is at x=15, y=3
    Sensor at x=14, y=3: closest beacon is at x=15, y=3
    Sensor at x=20, y=1: closest beacon is at x=15, y=3
  INPUT

  sig { void }
  def test_part1
    assert_equal 26, described_class.new(input).part1(10)
  end

  sig { void }
  def test_part2
    assert_equal 56_000_011, described_class.new(input).part2(20)
  end
end
