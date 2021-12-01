# frozen_string_literal: true

class SonarSweep
  def initialize(input)
    @input = input
    @depth = input.lines.map(&:to_i)
  end

  def part1
    increases = 0
    @depth.each_cons(2) do |a, b|
      increases += 1 if b > a
    end
    increases
  end

  def part2
    increases = 0
    @depth.each_cons(4) do |a, b, c, d|
      increases += 1 if b + c + d > a + b + c
    end
    increases
  end
end
