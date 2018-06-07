require 'set'

class Cubicles
  def initialize(input)
    @key = input.strip.to_i
    @queue = [[[1,1], 0]]
    @previous = {}
    @visited = {}
    @visited[[1, 1]] = 0
  end

  def open?(x, y)
    return false if x < 0 || y < 0
    ((x * x + 3 * x + 2 * x * y + y + y * y) + @key).to_s(2).chars.map(&:to_i).reduce(:+) % 2 == 0
  end

  def queue!(pos, moves, prev)
    return if @visited.key?(pos)
    return unless open?(*pos)
    @visited[pos] = moves
    @previous[pos] = prev
    @queue << [pos, moves]
  end

  def solve!
    while !@queue.empty?
      pos, moves = @queue.shift
      return moves if pos == @target
      [
        [pos[0] - 1, pos[1]],
        [pos[0] + 1, pos[1]],
        [pos[0], pos[1] - 1],
        [pos[0], pos[1] + 1],
      ].each do |neighbour|
        queue!(neighbour, moves + 1, pos)
      end
    end
  end

  def print!
    path = Set.new
    current = @target
    while current = @previous[current]
      path << current
    end

    (0..path.to_a.map(&:last).max + 10).each do |i|
      (0..path.to_a.map(&:first).max + 10).each do |j|
        if [j, i] == @target
          print 'X'
        elsif path.include?([j, i])
          print 'O'
        else
          print (open?(j, i) ? '.' : '#')
        end
      end
      puts ''
    end
  end

  def demo
    @target = [7, 4]
    solve!
  end

  def part1
    @target = [31, 39]
    solve!
  end

  def part2
    @target = [31, 39]
    solve!
    @visited.select { |_, v| v <= 50 }.size
  end
end
