# frozen_string_literal: true

class ShuttleSearch
  def initialize(input)
    @input = input
    @earliest = @input.split("\n")[0].to_i
    @buses = (@input.split("\n")[1].split(',') - %w[x]).map(&:to_i)
  end

  def part1
    next_departures = @buses.map do |bus|
      t = bus * (@earliest / bus)
      t += bus if t < @earliest
      [
        bus,
        t,
      ]
    end
    best = next_departures.min_by(&:last)

    best[0] * (best[1] - @earliest)
  end

  def part2
    t = 0
    lcm = 1

    @input.split("\n")[1].split(',').each_with_index do |bus, idx|
      next if bus == 'x'

      bus = bus.to_i

      loop do
        break if (idx + t) % bus == 0

        t += lcm
      end

      lcm = lcm.lcm(bus)
    end
    t
  end
end
