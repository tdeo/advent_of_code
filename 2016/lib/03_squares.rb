class Squares
  def initialize(input)
    @input = input
    @triangles = input.strip.split("\n").map { |l| l.strip.split.map(&:to_i) }
  end

  def valid?(triangle)
    triangle.sort!
    valid = triangle[0] + triangle[1] > triangle[2]
    valid
  end

  def part1
    @triangles.count { |t| valid?(t) }
  end

  def part2
    @triangles = @triangles.each_slice(3).flat_map { |a, b, c| a.zip(b, c) }
    @triangles.count { |t| valid?(t) }
  end
end
