require_relative 'intcode'

NORTH = 1
SOUTH = 2
WEST = 3
EAST = 4

class OxygenSystem
  def initialize(input)
    @input = input
    @intcode = Intcode.new(@input)
    @map = {}
  end

  def dist(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def path(from, to)
    viewed = { from => nil }
    q = [from]
    while !q.empty? do
      a = q.shift
      i, j = a
      [
        [i - 1, j, NORTH],
        [i + 1, j, SOUTH],
        [i, j + 1, EAST],
        [i, j - 1, WEST],
      ].each do |ii, jj, dir|
        if [ii, jj] == to
          path = [dir]
          cur = a.dup
          while viewed[cur]
            move, prev = viewed[cur]
            path << move
            cur = prev
          end
          return path.reverse
        end

        next unless @map[[ii, jj]] == ?.
        next if viewed.key?([ii, jj])

        viewed[[ii, jj]] = [dir, a]
        q << [ii, jj]
      end
    end
  end

  def moveto(to)
    a = nil
    way = path(@pos, to)
    # puts "Moving from #{@pos} to #{to}, path: #{way}"
    way.each do |dir|
      @intcode.sendint(dir)
      @intcode.run_until_input
      a = @intcode.getint
      # puts "\t Sent #{dir}, got status #{a}"
    end
    @map[to.dup] = case a
               when 0 then ?#
               when 1 then ?.
               when 2 then ?O
               end

    @pos = to
    if a == 0
      case way[-1]
      when NORTH then @pos[0] += 1
      when SOUTH then @pos[0] -= 1
      when EAST then @pos[1] -= 1
      when WEST then @pos[1] += 1
      end
    end
  end

  def print_map
    mini, maxi = @map.keys.map(&:first).minmax
    minj, maxj = @map.keys.map(&:last).minmax
    (mini .. maxi).each do |i|
      (minj .. maxj).each do |j|
        if i == 0 && j == 0
          print '0'
        else
          print @map[[i, j]] || ' '
        end
      end
      puts ''
    end
  end

  def part1
    @pos = [0, 0]
    queue = [@pos]
    @map[[0, 0]] = ?.

    while !queue.empty? do
      todo = queue.shift
      i, j = todo
      [[i - 1, j], [i + 1, j], [i, j - 1], [i, j + 1]].each do |neighbour|
        next if @map[neighbour]
        moveto(neighbour)
        queue << neighbour
      end
    end
    print_map
    tank = @map.find { |k, v| v == ?O }[0]
    path([0, 0], tank).size
  end

  def part2
    part1
    tank = @map.find { |k, v| v == ?O }[0]
    q = [tank]
    viewed = { tank => 0 }
    while !q.empty? do
      a = q.shift
      i, j = a
      [[i - 1, j], [i + 1, j], [i, j - 1], [i, j + 1]].each do |neighbour|
        next if @map[neighbour] != ?.
        next if viewed[neighbour]
        viewed[neighbour] = 1 + viewed[a]
        q <<  neighbour
      end
    end
    viewed.values.max
  end
end
