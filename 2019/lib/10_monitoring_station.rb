# frozen_string_literal: true

class MonitoringStation
  def initialize(input)
    @input = input
    @asteroids = []
    @input.each_line.with_index do |r, i|
      r.chars.each_with_index do |c, j|
        @asteroids << [j, i] if c == '#'
      end
    end
  end

  def visible_from(i)
    viewed = Hash.new { |h, k| h[k] = [] }
    (0...@asteroids.size).each do |j|
      next if i == j

      d0 = @asteroids[j][0] - @asteroids[i][0]
      d1 = @asteroids[j][1] - @asteroids[i][1]

      g = if d0 == 0
            d1
          elsif d1 == 0
            d0
          else
            d0.gcd(d1)
          end
      g = g.abs
      viewed[[d0 / g, d1 / g]] << @asteroids[j]
    end
    viewed
  end

  def part1
    (0...@asteroids.size).map { |i| visible_from(i).size }.max
  end

  def part2
    i = (0...@asteroids.size).max_by { |j| visible_from(j).size }
    targets = visible_from(i)
    order = []
    keys = targets.keys.sort_by do |k|
      Math.atan2(-k[0], k[1])
    end
    keys.each do |k|
      targets[k].sort_by! do |t|
        (t[0] - @asteroids[i][0]).abs + (t[1] - @asteroids[i][1]).abs
      end
    end
    keys.unshift(keys.pop) # The vertical direction gets at the end because of ]-PI,PI]
    100.times do
      keys.each do |k|
        next if targets[k].empty?

        order << targets[k].shift
      end
    end
    (order[199][0] * 100) + order[199][1]
  end
end
