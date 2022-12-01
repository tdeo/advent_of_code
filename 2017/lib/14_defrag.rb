# frozen_string_literal: true

require_relative '10_knot'

class Defrag
  def initialize(input)
    @input = input.strip
    @size = 128
    @rows = (0...@size).map { |i| "#{@input}-#{i}" }
    @knots = @rows.map { |r| Knot.new(r).part2 }
    @grid = @knots.map { |k| k.hex.to_s(2).rjust(@size, '0').chars.map(&:to_i) }
  end

  def print
    puts(@grid.first(8).map { |r| r.first(8).join.tr('0', '.') })
  end

  def part1
    @grid.flat_map { |r| r }.sum
  end

  def find_bit
    (0...@size).each do |r|
      (0...@size).each do |c|
        return [r, c] if @grid[r][c] == 1
      end
    end
    [nil, nil]
  end

  def clear_neighbours!(r, c, fillval = 0)
    todo = [[r, c]]
    @grid[r][c] = fillval
    until todo.empty?
      a, b = todo.pop
      [
        [a - 1, b],
        [a + 1, b],
        [a, b - 1],
        [a, b + 1],
      ].each do |i, j|
        next if i >= @size || j >= @size || i < 0 || j < 0
        next unless @grid[i][j] == 1

        @grid[i][j] = fillval
        todo << [i, j]
      end
    end
  end

  def part2
    regions = 0
    loop do
      r, c = find_bit
      break if r.nil?

      regions += 1
      clear_neighbours!(r, c, 0)
    end
    regions
  end
end
