# frozen_string_literal: true

require 'set'

class SphericalHouses
  def initialize(input)
    @input = input.strip
  end

  def part1
    x = y = 0
    visited = Set.new
    visited << [0, 0]
    @input.each_char do |c|
      case c
      when '>' then x += 1
      when '<' then x -= 1
      when '^' then y += 1
      when 'v' then y -= 1
      end
      visited << [x, y]
    end
    visited.size
  end

  def part2
    x = [0, 0]
    y = [0, 0]
    visited = Set.new
    visited << [0, 0]
    @input.each_char.with_index do |c, i|
      case c
      when '>' then x[i % 2] += 1
      when '<' then x[i % 2] -= 1
      when '^' then y[i % 2] += 1
      when 'v' then y[i % 2] -= 1
      end
      visited << [x[i % 2], y[i % 2]]
    end
    visited.size
  end
end
