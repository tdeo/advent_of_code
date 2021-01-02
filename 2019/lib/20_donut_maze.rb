# frozen_string_literal: true

require_relative '../../lib/priority_queue'

class DonutMaze
  def initialize(input)
    @input = input
    @maze = input.split("\n").reject(&:empty?)
    @portals = Hash.new { |h, k| h[k] = [] }
    (1..@maze.size - 2).each do |i|
      line = @maze[i]
      (1..line.size - 2).each do |j|
        c = line[j]
        next unless ('A'..'Z').cover?(c)

        if line[j + 1] == '.'
          @portals[line[j - 1] + c] << [i, j + 1]
        elsif line[j - 1] == '.'
          @portals[c + line[j + 1]] << [i, j - 1]
        elsif @maze[i - 1][j] == '.'
          @portals[c + @maze[i + 1][j]] << [i - 1, j]
        elsif @maze[i + 1][j] == '.'
          @portals[@maze[i - 1][j] + c] << [i + 1, j]
        end
      end
    end
    @start = @portals['AA'][0]
    @end = @portals['ZZ'][0]
    @rev_portals = {}
    @portals.each do |k, v|
      v.each { |pos| @rev_portals[pos] = k + (outward?(pos) ? 'o' : 'i') }
    end
  end

  def accessible(portal)
    @accessible ||= {}
    @accessible[portal] ||= begin
      q = @rev_portals.find { |_, v| v == portal }[0..0]
      viewed = q.map { |e| [e, 0] }.to_h

      res = {}
      res[portal.tr('io', 'oi')] = 1 if portal != 'AAo' && portal != 'ZZo'

      until q.empty?
        pos = q.shift
        res[@rev_portals[pos]] = viewed[pos] if @rev_portals[pos]
        i, j = pos
        [[i + 1, j], [i, j + 1], [i - 1, j], [i, j - 1]].each do |n|
          ii, jj = n
          next unless @maze[ii][jj] == '.'
          next if viewed[n]

          viewed[n] = viewed[pos] + 1
          q << n
        end
      end

      res
    end
  end

  def part1
    q = PriorityQueue.new(&:first)
    q << [0, 'AAo']
    viewed = {}

    until q.empty?
      d, cur = q.pop
      return d if cur == 'ZZo'

      next if viewed[cur]

      viewed[cur] = d

      accessible(cur).each do |n, v|
        dist, = v
        q << [d + dist, n]
      end
    end
  end

  def outward?(pos)
    @outward ||= {}
    @outward[pos] ||= begin
      d = [
        [pos[0], @maze.size - pos[0] - 1].min,
        [pos[1], @maze[0].size - pos[1] - 1].min,
      ].min
      d <= 3
    end
  end

  def part2
    q = PriorityQueue.new(&:first)
    q << [0, 'AAo', 0, nil]
    viewed = {}
    final = nil

    until q.empty?
      d, cur, level, from = q.pop
      next if viewed.key?([cur, level])

      viewed[[cur, level]] = from

      if cur == 'ZZo' && level == 0
        final = d
        break
      end

      accessible(cur).each do |n, dist|
        next if n == cur
        next if n == 'AAo'

        next_level = level
        if n[0..1] == cur[0..1]
          next_level += (n[2] == 'i' ? -1 : 1)
        end

        next if n == 'ZZo' && level != 0
        next if next_level < 0

        q << [d + dist, n, next_level, [cur, level]]
      end
    end

    path = [['ZZo', 0]]
    path << viewed[path[-1]] while viewed[path[-1]]
    final
  end
end
