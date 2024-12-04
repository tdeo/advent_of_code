# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CeresSearch
  extend T::Sig

  DIRECTIONS = T.let([
    [1, 0], [-1, 0], [0, 1], [0, -1],
    [1, 1], [-1, -1], [1, -1], [-1, 1],
  ].freeze, T::Array[[Integer, Integer]],)

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @grid = T.let(@input.lines(chomp: true).map(&:chars), T::Array[T::Array[String]])
  end

  sig { returns(Integer) }
  def part1
    @grid.each_with_index.sum do |row, i|
      row.each_with_index.sum do |_c, j|
        DIRECTIONS.count do |di, dj|
          next unless i + (3 * di) >= 0 && j + (3 * dj) >= 0 && i + (3 * di) < @grid.size && j + (3 * dj) < row.size

          x = T.must(@grid[i])[j]
          m = T.must(@grid[i + di])[j + dj]
          a = T.must(@grid[i + (2 * di)])[j + (2 * dj)]
          s = T.must(@grid[i + (3 * di)])[j + (3 * dj)]
          x == 'X' && m == 'M' && a == 'A' && s == 'S'
        end
      end
    end
  end

  sig { returns(Integer) }
  def part2
    @grid.each_with_index.sum do |row, i|
      row.each_with_index.count do |_c, j|
        DIRECTIONS.last(4).count do |di, dj|
          next unless i >= 1 && j >= 1 && i < @grid.size - 1 && j < @grid.size - 1

          m = T.must(@grid[i - di])[j - dj]
          a = T.must(@grid[i])[j]
          s = T.must(@grid[i + di])[j + dj]
          m == 'M' && a == 'A' && s == 'S'
        end > 1
      end
    end
  end
end
