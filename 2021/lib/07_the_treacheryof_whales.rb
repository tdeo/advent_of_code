# frozen_string_literal: true

class TheTreacheryofWhales
  def initialize(input)
    @input = input
    @crabs = input.split(',').map(&:to_i)
  end

  def part1
    @crabs.sort!
    best = @crabs[@crabs.size / 2]
    @crabs.sum { (_1 - best).abs }
  end

  def part2
    @crabs.sort!
    best = Float::INFINITY
    (@crabs.min..@crabs.max).each do |pos|
      cost = @crabs.sum do |crab|
        delta = (crab - pos).abs
        (delta * (delta + 1)) / 2
      end

      best = [best, cost].min
    end
    best
  end
end
