# frozen_string_literal: true

class Lanternfish
  def initialize(input)
    @input = input
    @fishes = Hash.new(0)
    @input.split(',').each { @fishes[_1.to_i] += 1 }
  end

  def next_day!
    succ = Hash.new(0)

    (1..8).each do |i|
      succ[i - 1] = @fishes[i]
    end
    succ[8] += @fishes[0]
    succ[6] += @fishes[0]

    @fishes = succ
  end

  def part1(days = 80)
    days.times { next_day! }
    @fishes.values.sum
  end

  def part2
    part1(256)
  end
end
