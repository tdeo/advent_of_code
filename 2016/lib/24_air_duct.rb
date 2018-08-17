require 'set'

class AirDuct
  def initialize(input)
    @input = input
    @maze = input.split("\n")
  end

  def open?(x, y)
    @maze[x][y] != '#'
  end

  def shortest_path(x1, y1, x2, y2)
    visited = Set.new([[x1, y1]])
    queue = [[x1, y1, 0]]
    while !queue.empty?
      x, y, l = queue.shift
      return l if x == x2 && y == y2
      [
        [x - 1, y],
        [x + 1, y],
        [x, y - 1],
        [x, y + 1],
      ].each do |n|
        next unless open?(*n)
        next if visited.include?(n)
        visited << n
        queue << [*n, l + 1]
      end
    end
  end

  def part1
    targets = @maze.each_with_index.flat_map do |row, x|
      row.chars.each_with_index.map do |c, y|
        [c.to_i, [x, y]] if c =~ /\d/
      end
    end.compact.to_h
    distances = Hash.new { |h, k| h[k] = {} }
    targets.each do |a, aa|
      distances[a][a] = 0
      targets.each do |b, bb|
        # next unless a < b
        distances[a][b] = distances[b][a] = shortest_path(*aa, *bb)
      end
    end
    (targets.keys - [0]).permutation.map do |p|
      p.unshift(0)
      p.each_cons(2).map { |a, b| distances[a][b] }.sum
    end.min
  end

  def part2
    targets = @maze.each_with_index.flat_map do |row, x|
      row.chars.each_with_index.map do |c, y|
        [c.to_i, [x, y]] if c =~ /\d/
      end
    end.compact.to_h
    distances = Hash.new { |h, k| h[k] = {} }
    targets.each do |a, aa|
      distances[a][a] = 0
      targets.each do |b, bb|
        # next unless a < b
        distances[a][b] = distances[b][a] = shortest_path(*aa, *bb)
      end
    end
    (targets.keys - [0]).permutation.map do |p|
      p.unshift(0)
      p.push(0)
      p.each_cons(2).map { |a, b| distances[a][b] }.sum
    end.min
  end
end
