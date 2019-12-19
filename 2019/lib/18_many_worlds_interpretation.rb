require_relative '../../lib/priority_queue'

class ManyWorldsInterpretation
  def initialize(input)
    @input = input.strip
    @maze = @input.split("\n")
    @origin = nil
    @pos = {}
    (0...@maze.size).each do |i|
      (0...@maze[i].size).each do |j|
        @pos[at(i, j)] = [i, j] if at(i, j) != ?# && at(i, j) != ?.
      end
    end
  end

  def at(i, j)
    @maze[i][j]
  end

  def neighbours(pos)
    i, j = pos
    [[i + 1, j], [i, j + 1], [i, j - 1], [i - 1, j]].each do |ii, jj|
      yield [ii, jj] if at(ii, jj) != ?#
    end
  end

  def has_cycle?
    viewed = { @origin => nil }
    q = [@origin]
    while !q.empty? do
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

  def key_information
    keys = {}
    viewed = { @origin => [] }
    q = [@origin]
    while !q.empty? do
      cur = q.shift
      neighbours(cur) do |n|
        next if viewed[n]

        c = at(n)
        if (?A...?Z) === c || (?a...?z) === c
          viewed[n] = viewed[cur] + [c]
        else
          viewed[n] = viewed[cur]
        end
        q << n

        if (?a..?z) === c
          keys[c] = { pos: n, needs: viewed[cur].dup }
        end
      end
    end
    keys.keys.each do |k|
      keys[k] = {
        pos: keys[k][:pos],
        keys: keys[k][:needs].select { |e| (?a...?z) === e }.sort,
        doors: keys[k][:needs].select { |e| (?A...?Z) === e }.map(&:downcase).sort,
      }
    end
    keys
  end

  def shortest_paths(from)
    @shortest ||= {}
    pos = @pos[from]
    puts pos
    @shortest[from] ||= begin
      v = { pos => [0, []] }
      q = [pos]
      while !q.empty? do
        cur = q.shift
        s = at(*cur)

        neighbours(cur) do |n|
          next if v.key?(n)
          v[n] = [
            v[cur][0] + 1,
            s =~ /[A-Za-z]/ ? v[cur][1] + [s.downcase] : v[cur][1],
          ]
          q << n
        end
      end
      @pos.keys.select { |k| k =~ /[a-z]/ }.map { |k| [k, v[@pos[k]]] }.to_h
    end
  end

  def enhance(key_info)
    res = []
    key_info.each do |k, info|
      info[:letter] = k
      info[:doors] = info[:doors].map { |e| 1 << (e.ord - ?a.ord) }.reduce(0, :|)
      info[:keys] = info[:keys].map { |e| 1 << (e.ord - ?a.ord) }.reduce(0, :|)
      res[k.ord - ?a.ord] = info
    end
    res
  end

  def print_map
    @maze.each do |l|
      puts l.tr('#.', "\u2588 ")
    end
  end

  def part1
    puts shortest_paths(?@)
    # print_map
    key_infos = key_information.sort.to_h
    # pp key_infos.map { |k, v| [k, v[:doors].sort.join(',')].join(', ') }
    key_infos = enhance(key_infos)
    # pp key_infos.map { |e| e.merge({ doors: e[:doors].to_s(2), keys: e[:keys].to_s(2) }) }

    target = (1 << key_infos.size) - 1

    # q = PriorityQueue.new { |el| el.first }
    q = []
    # viewed = {}
    q << [0, [@origin, 0]]
    best = 10000000

    while !q.empty? do
      val, el = q.pop
      pos, visited = el
      if visited == target
        best = val if val < best
      end

      # next if viewed[el]
      # viewed[el] = val

      key_infos.each_with_index do |info, k|
        next if visited[k] != 0
        next unless info[:doors] & visited == info[:doors]
        q << [
          val + shortest_path(pos, info[:pos]),
          [
            info[:pos],
            visited | (1 << k)
          ],
          pos
        ]
      end
    end
    best
  end

  def part2
    true
  end
end
