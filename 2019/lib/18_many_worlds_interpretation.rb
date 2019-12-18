require_relative '../../lib/priority_queue'

class ManyWorldsInterpretation
  def initialize(input)
    @input = input.strip
    @maze = @input.split("\n")
    @origin = nil
    (0...@maze.size).each do |i|
      (0...@maze[i].size).each do |j|
        @origin = [i, j] if at(i, j) == ?@
      end
    end
  end

  def at(i, j = nil)
    j.nil? ? @maze[i[0]][i[1]] : @maze[i][j]
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

  def shortest_path(from, to)
    @shortest ||= {}
    @time ||= 0
    @shortest[[from, to]] ||= @shortest[[to, from]] ||= begin
      @time -= Time.now.to_f
      v = { from => 0 }
      q = [from]
      ret = nil
      while !q.empty? do
        cur = q.shift
        if cur == to
          ret = v[cur]
          break
        end
        neighbours(cur) do |n|
          next if v.key?(n)
          v[n] = v[cur] + 1
          q << n
        end
      end
      @time += Time.now.to_f
      # puts "#{from} #{to} #{@time.round(3)}"
      fail "No path from #{from} to #{to}" if ret.nil?
      ret
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

  def part1
    key_infos = enhance(key_information.sort.to_h)
    # pp key_infos.map { |e| e.merge({ doors: e[:doors].to_s(2), keys: e[:keys].to_s(2) }) }

    target = (1 << key_infos.size) - 1

    q = PriorityQueue.new { |el| el.first }
    viewed = {}
    q << [0, [@origin, 0]]

    while !q.empty? do
      val, el = q.pop
      pos, visited = el
      return val if visited == target

      next if viewed[el]
      viewed[el] = val

      key_infos.each_with_index do |info, k|
        next if visited[k] != 0
        next unless info[:doors] & visited == info[:doors]
        q << [
          val + shortest_path(pos, info[:pos]),
          [
            info[:pos],
            visited | (1 << k)
          ]
        ]
      end
    end
  end

  def part2
    true
  end
end
