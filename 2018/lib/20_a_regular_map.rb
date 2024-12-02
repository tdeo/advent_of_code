# frozen_string_literal: true

class ARegularMap
  def initialize(input)
    @input = input
    @map = Hash.new { |h, k| h[k] = {} }
    @mini = @minj = @maxi = @maxj = 0
    parse!
  end

  def parse!
    pos = [0, 0]
    stack = [[0, 0]]
    @map[0][0] = 'X'

    @input.each_char do |c|
      case c
      when '|'
        pos = stack[-1].dup
      when '('
        stack << pos.dup
      when ')'
        stack.pop
      end
      i, j = pos # row, col
      case c
      when 'N'
        @map[i - 1][j] = '-'
        pos[0] -= 2
      when 'W'
        @map[i][j - 1] = '|'
        pos[1] -= 2
      when 'S'
        @map[i + 1][j] = '-'
        pos[0] += 2
      when 'E'
        @map[i][j + 1] = '|'
        pos[1] += 2
      end

      @map[pos[0]][pos[1]] = '.'

      @mini = pos[0] if pos[0] < @mini
      @maxi = pos[0] if pos[0] > @maxi
      @minj = pos[1] if pos[1] < @minj
      @maxj = pos[1] if pos[1] > @maxj
    end
    @map[0][0] = 'X'
  end

  def dfs(start)
    queue = [start]
    vis = { start => 0 }

    until queue.empty?
      c = queue.shift
      if @map[c[0]][c[1] - 1] == '|' && !vis[[c[0], c[1] - 2]]
        vis[[c[0], c[1] - 2]] = 1 + vis[c]
        queue << [c[0], c[1] - 2]
      end
      if @map[c[0]][c[1] + 1] == '|' && !vis[[c[0], c[1] + 2]]
        vis[[c[0], c[1] + 2]] = 1 + vis[c]
        queue << [c[0], c[1] + 2]
      end
      if @map[c[0] + 1][c[1]] == '-' && !vis[[c[0] + 2, c[1]]]
        vis[[c[0] + 2, c[1]]] = 1 + vis[c]
        queue << [c[0] + 2, c[1]]
      end
      if @map[c[0] - 1][c[1]] == '-' && !vis[[c[0] - 2, c[1]]]
        vis[[c[0] - 2, c[1]]] = 1 + vis[c]
        queue << [c[0] - 2, c[1]]
      end
    end

    vis
  end

  def print!
    (@mini..@maxi).each do |i|
      (@minj..@maxj).each do |j|
        print(@map[i][j] || ' ')
      end
      puts ''
    end
  end

  def part1
    visited = dfs([0, 0])
    visited.values.max
  end

  def part2
    visited = dfs([0, 0])
    visited.count { |_, v| v >= 1000 }
  end
end
