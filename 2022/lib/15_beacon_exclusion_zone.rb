# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class BeaconExclusionZone
  extend T::Sig

  class Coord < T::Struct
    const :x, Integer
    const :y, Integer
  end

  class Sensor < T::Struct
    const :pos, Coord
    const :beacon, Coord
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @sensors = T.let([], T::Array[Sensor])
    @input.split("\n").each do |line|
      match = T.must(line.match(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/))
      @sensors << Sensor.new(
        pos: Coord.new(x: match[1].to_i, y: match[2].to_i),
        beacon: Coord.new(x: match[3].to_i, y: match[4].to_i),
      )
    end
  end

  sig { params(a: Coord, b: Coord).returns(Integer) }
  def dist(a, b)
    (a.x - b.x).abs + (a.y - b.y).abs
  end

  Ranges = T.type_alias { T::Array[[Integer, Integer]] }

  sig { params(ranges: Ranges).void }
  def dedup(ranges)
    ranges.sort_by!(&:first)

    i = 0
    while i < ranges.size - 1
      next i += 1 unless T.must(ranges[i + 1])[0] <= 1 + T.must(ranges[i])[1]

      T.must(ranges[i])[1] = [T.must(ranges[i])[1], T.must(ranges[i + 1])[1]].max
      ranges.delete_at(i + 1)
    end
  end

  sig { params(y: Integer).returns(Ranges) }
  def blocked_ranges(y)
    ranges = T.let([], Ranges)
    @sensors.each do |sens|
      closest = dist(sens.pos, sens.beacon)
      remainder = closest - (y - sens.pos.y).abs
      next if remainder < 0

      ranges << [sens.pos.x - remainder, sens.pos.x + remainder]
    end

    dedup(ranges)
    ranges
  end

  sig { params(y: Integer).returns(Integer) }
  def part1(y = 2_000_000)
    ranges = blocked_ranges(y)

    total = ranges.sum { |a, b| b - a + 1 }
    beacons = Set.new
    @sensors.each do |sens|
      beacons << sens.beacon.x if sens.beacon.y == y
    end
    total - beacons.size
  end

  sig { params(bound: Integer).returns(Integer) }
  def part2(bound = 4_000_000)
    (0...bound).each do |y|
      ranges = blocked_ranges(y)

      next if ranges.any? { |a, b| a <= 0 && b >= bound }

      x = ranges.find { _1.last <= bound }&.last.to_i + 1
      return (x * 4_000_000) + y
    end

    raise 'No position found!'
  end
end
