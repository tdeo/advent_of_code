# frozen_string_literal: true

require_relative '../../lib/priority_queue'

class ManyWorldsInterpretation
  def initialize(input)
    @input = input.strip
    @maze = @input.split("\n")
    @origin = nil
    @pos = {}
    read_positions
  end

  def read_positions
    (0...@maze.size).each do |i|
      (0...@maze[i].size).each do |j|
        @pos[at(i, j)] = [i, j] if at(i, j) != '#' && at(i, j) != '.'
      end
    end
  end

  def at(i, j)
    @maze[i][j]
  end

  def neighbours(pos)
    i, j = pos
    [[i + 1, j], [i, j + 1], [i, j - 1], [i - 1, j]].each do |ii, jj|
      yield [ii, jj] if at(ii, jj) != '#'
    end
  end

  def cycles?
    viewed = { @pos['@'] => nil }
    q = [@pos['@']]
    until q.empty?
      cur = q.shift
      neighbours(cur) do |n|
        next if viewed[cur] == n

        if viewed.key?(n)
          return true if viewed[n] != cur

          next
        end

        viewed[n] = cur
        q << n
      end
    end
    false
  end

  def shortest_paths(from)
    @shortest ||= {}
    pos = @pos[from]
    @shortest[from] ||= begin
      v = { pos => [0, []] }
      q = [pos]
      until q.empty?
        cur = q.shift
        s = at(*cur)

        neighbours(cur) do |n|
          next if v.key?(n)

          v[n] = [
            v[cur][0] + 1,
            /[A-Za-z]/.match?(s) ? v[cur][1] + [s.downcase] : v[cur][1],
          ]
          q << n
        end
      end
      @pos.keys.select { |k| k =~ /[a-z]/ && v.key?(@pos[k]) }.to_h do |k|
        [k, v[@pos[k]]]
      end
    end
  end

  def print_maze
    @maze.each do |l|
      puts l.tr('#.', "\u2588 ")
    end
  end

  def part1
    target = @pos.count { |k, _| k =~ /[a-z]/ }

    q = PriorityQueue.new(&:first)
    q << [0, ['@', {}]]

    viewed = {}

    until q.empty?
      val, el = q.pop
      pos, visited = el

      return val if visited.size == target

      next if viewed[el]

      viewed[el] = val

      shortest_paths(pos).each do |k, v|
        next if visited.key?(k)
        next unless v[1].all? { |vv| visited.key?(vv) }

        q << [val + v[0], [k, visited.merge({ k => true })]]
      end

    end
    best
  end

  def part2
    i, j = @pos['@']
    @maze[i - 1][j - 1..j + 1] = '1#2'
    @maze[i][j - 1..j + 1] = '###'
    @maze[i + 1][j - 1..j + 1] = '3#4'

    @pos = {}
    read_positions
    @shortest = {}

    target = @pos.count { |k, _| k =~ /[a-z]/ }

    q = PriorityQueue.new(&:first)
    q << [0, ['1234', {}]]

    viewed = {}

    until q.empty?
      val, el = q.pop
      poss, visited = el

      return val if visited.size == target

      next if viewed[el]

      viewed[el] = val

      poss.each_char do |pos|
        shortest_paths(pos).each do |k, v|
          next if visited.key?(k)
          next unless v[1].all? { |vv| visited.key?(vv) }

          q << [
            val + v[0],
            [
              poss.tr(pos, k),
              visited.merge({ k => true }),
            ],
          ]
        end
      end
    end
  end
end
