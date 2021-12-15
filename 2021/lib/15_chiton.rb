# frozen_string_literal: true

require_relative '../../lib/priority_queue'

class Chiton
  def initialize(input)
    @input = input
    @grid = @input.split("\n").map { _1.chars.map(&:to_i) }
    @height = @grid.size
    @width = @grid[0].size
  end

  def neighbours(i, j)
    res = []
    res << [i + 1, j] if i < @grid.size - 1
    res << [i - 1, j] if i > 0
    res << [i, j + 1] if j < @grid[i].size - 1
    res << [i, j - 1] if j > 0
    res
  end

  def part1
    queue = PriorityQueue.new(&:first)
    queue << [0, [0, 0]]
    visited = { [0, 0] => true }

    until queue.empty?
      score, pos = queue.pop
      i, j = pos

      return score if i == @grid.size - 1 && j == @grid[-1].size - 1

      neighbours(i, j).each do |ii, jj|
        next if visited[[ii, jj]]

        visited[[ii, jj]] = true
        queue << [
          score + @grid[ii][jj],
          [ii, jj],
        ]
      end
    end
  end

  def print!
    @grid.each { puts _1.join }
  end

  def succ(e)
    e == 9 ? 1 : e + 1
  end

  def expand!(times = 4)
    times.times do
      @grid.each do |row|
        to_append = (-@width...0).map { succ(row[_1]) }
        row.push(*to_append)
      end
    end

    times.times do
      to_append = (-@height...0).map do |i|
        @grid[i].map { succ(_1) }
      end
      @grid.push(*to_append)
    end
  end

  def part2
    expand!
    part1
  end
end
