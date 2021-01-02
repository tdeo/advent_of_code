# frozen_string_literal: true

class ChronalCoordinates
  def initialize(input)
    @input = input

    @points = @input.split("\n").map { |e| e.split(', ').map(&:to_i) }
  end

  def d(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def closest(x, y)
    best_d = Float::INFINITY
    best_point = nil
    @points.each_with_index do |point, i|
      dist = d([x, y], point)
      if dist < best_d
        best_point = i
        best_d = dist
      elsif dist == best_d
        best_point = nil
      end
    end
    best_point
  end

  def dist_sum(x, y, threshold)
    s = 0
    @points.each do |point|
      s += d([x, y], point)
      return s if s > threshold
    end
    s
  end

  def part1
    zones = Hash.new { |h, k| h[k] = 0 }

    (@points.map(&:first).min..@points.map(&:first).max).each do |x|
      (@points.map(&:last).min..@points.map(&:last).max).each do |y|
        zones[closest(x, y)] += 1
      end
    end

    @points.map(&:first).minmax.each do |x|
      (@points.map(&:last).min..@points.map(&:last).max).each do |y|
        zones.delete(closest(x, y))
      end
    end

    (@points.map(&:first).min..@points.map(&:first).max).each do |x|
      @points.map(&:last).minmax.each do |y|
        zones.delete(closest(x, y))
      end
    end
    zones.delete(nil)
    zones.values.max
  end

  def part2(n = 10_000)
    count = 0
    (@points.map(&:first).min..@points.map(&:first).max).each do |x|
      (@points.map(&:last).min..@points.map(&:last).max).each do |y|
        count += 1 if dist_sum(x, y, n) < n
      end
    end
    count
  end
end
