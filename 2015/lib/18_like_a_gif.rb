# frozen_string_literal: true

class LikeAGif
  def initialize(input)
    @grid = []
    input.split("\n").each do |l|
      row = 0
      l.each_char do |c|
        row += 1 if c == '#'
        row <<= 1
      end
      row >>= 1
      @grid << row
    end
  end

  def corners!
    @grid[0] |= (1 << @grid.size - 1) | 1
    @grid[-1] |= (1 << @grid.size - 1) | 1
  end

  def neighbours(i, j)
    ([i - 1, 0].max..i + 1).sum do |i2|
      ([j - 1, 0].max..j + 1).sum do |j2|
        @grid[i2].to_i[j2]
      end
    end
  end

  def print
    @grid.each do |row|
      puts row.to_s(2).rjust(@grid.size, '0').tr('01', '.#')
    end
  end

  def next_row(i)
    a = 0
    (0...@grid.size).reverse_each do |j|
      n = neighbours(i, j)
      a += 1 if (@grid[i][j] == 1 && n == 4) || n == 3
      a <<= 1
    end
    a >>= 1
  end

  def next_grid!
    new_grid = []
    (0...@grid.size).each { |i| new_grid << next_row(i) }
    @grid = new_grid
  end

  def part1(steps = 100)
    steps.times { next_grid! }
    @grid.sum { |row| row.to_s(2).count('1') }
  end

  def part2(steps = 100)
    corners!
    steps.times do
      next_grid!
      corners!
    end
    @grid.sum { |row| row.to_s(2).count('1') }
  end
end
