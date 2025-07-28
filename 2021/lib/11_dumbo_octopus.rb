# frozen_string_literal: true

class DumboOctopus
  def initialize(input)
    @input = input
    @octopuses = @input.split("\n").map { _1.chars.map(&:to_i) }
    @flashes = 0
  end

  def flash!(i, j)
    @flashes += 1
    ((i - 1)..(i + 1)).each do |ii|
      next if ii < 0 || ii >= @octopuses.size

      ((j - 1)..(j + 1)).each do |jj|
        next if jj < 0 || jj >= @octopuses[ii].size
        next if jj == j && ii == i

        increment!(ii, jj)
      end
    end
  end

  def increment!(i, j)
    @octopuses[i][j] += 1
    flash!(i, j) if @octopuses[i][j] == 10
  end

  def step!
    (0...@octopuses.size).each do |i|
      (0...@octopuses[i].size).each do |j|
        increment!(i, j)
      end
    end

    reset!
  end

  def reset!
    (0...@octopuses.size).each do |i|
      (0...@octopuses[i].size).each do |j|
        @octopuses[i][j] = 0 if @octopuses[i][j] > 9
      end
    end
  end

  def part1(times = 100)
    times.times { step! }
    @flashes
  end

  def part2
    prev_count = 0
    (1..).each do |i|
      step!

      return i if (@flashes - prev_count) == @octopuses.sum(&:size)

      prev_count = @flashes
    end
  end
end
