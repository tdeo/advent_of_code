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

  def find_blocking_doors
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
    @shortest[[from, to]] ||= @shortest[[to, from]] ||= begin
      v = { from => 0 }
      q = [from]
      while !q.empty? do
        cur = q.shift
        return v[cur] if cur == to
        neighbours(cur) do |n|
          next if v.key?(n)
          v[n] = v[cur] + 1
          q << n
        end
      end
      fail "No path from #{from} to #{to}"
    end
  end

  def order(prefix, blocking = find_blocking_doors)
    if prefix.size == blocking.size
      yield prefix
      return
    end
    blocking.keys.each do |k|
      next if prefix.include?(k)
      next unless blocking[k][:doors].all? { |door| prefix.include?(door) }

      order(prefix.merge({ k => true }), blocking) do |poss|
        yield poss
      end
    end
  end

  def part1
    blocking = find_blocking_doors.sort.reverse.to_h
    pp blocking
    c = 0
    order({}, blocking) do |opt|
      c += 1
      puts opt.keys.join(',') if c % 100_000 == 0
      puts c if c % 100_000 == 0
    end
    c
  end

  def part2
  end
end
