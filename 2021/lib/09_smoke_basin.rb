# frozen_string_literal: true

class SmokeBasin
  def initialize(input)
    @input = input
    @grid = @input.lines.map { _1.chomp.chars.map(&:to_i) }
  end

  def neighbours(i, j)
    [[i + 1, j], [i - 1, j], [i, j + 1], [i, j - 1]].select do |ii, jj|
      ii >= 0 && ii < @grid.size && jj >= 0 && jj < @grid[ii].size
    end
  end

  def low_point?(i, j)
    neighbours(i, j).all? do |ii, jj|
      @grid[ii][jj] > @grid[i][j]
    end
  end

  def low_points
    res = []
    (0...@grid.size).each do |i|
      (0...@grid[i].size).each do |j|
        next unless low_point?(i, j)

        res << [i, j]
      end
    end
    res
  end

  def part1
    low_points.sum do |i, j|
      1 + @grid[i][j]
    end
  end

  def basin_size(i, j)
    q = [[i, j]]
    queued = { q[0] => true }

    until q.empty?
      i, j = q.shift

      neighbours(i, j).each do |ii, jj|
        next if @grid[ii][jj] == 9
        next if queued[[ii, jj]]

        queued[[ii, jj]] = true
        q << [ii, jj]
      end
    end
    queued.size
  end

  def part2
    top = [0, 0, 0]
    low_points.each do |i, j|
      size = basin_size(i, j)

      top = [*top, size].sort.last(3) if size > top[0]
    end
    top.reduce(:*)
  end
end
