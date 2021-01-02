# frozen_string_literal: true

class Timing
  def initialize(input)
    @wheels = {}
    input.split("\n").each do |l|
      m = l.match(/^Disc #(\d+) has (\d+) positions; at time=0, it is at position (\d+).$/)
      next if m.nil?

      @wheels[m[1].to_i] = [m[2].to_i, m[3].to_i]
    end
  end

  def valid?(time)
    @wheels.all? do |idx, wheel|
      (time + idx + wheel[1]) % wheel[0] == 0
    end
  end

  def run!
    i = 0
    i += 1 until valid?(i)
    i
  end

  def part1
    run!
  end

  def part2
    @wheels[@wheels.keys.max + 1] = [11, 0]
    run!
  end
end
