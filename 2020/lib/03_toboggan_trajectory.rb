# frozen_string_literal: true

class TobogganTrajectory
  TREE = '#'

  def initialize(input)
    @input = input
    @map = @input.split("\n")
    @width = @map[0].size
    @height = @map.size
  end

  def trees(dx, dy)
    x = y = 0
    trees = 0
    while y < @height
      trees += 1 if @map[y][x % @width] == TREE
      x += dx
      y += dy
    end
    trees
  end

  def part1
    trees(3, 1)
  end

  def part2
    [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2],
    ].map { |arg| trees(*arg) }.reduce(1, :*)
  end
end
