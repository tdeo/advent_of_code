# frozen_string_literal: true

require_relative '../../lib/priority_queue'

class ModeMaze
  MOD = 20_183
  OBJECTS = [0, 1, 2].freeze

  def initialize(input)
    @input = input
    @depth = input[/depth: (\d+)$/, 1].to_i
    @target = input[/target: (\d+,\d+)$/, 1].split(',').map(&:to_i)
    compute!
  end

  def compute!
    upto = @target.map { |e| e + 600 }
    @erosion = Array.new(upto[0]) { Array.new(upto[1]) }
    (0...upto[0]).each do |x|
      (0...upto[1]).each do |y|
        @erosion[x][y] = if x == 0
                           (y * 48_271 + @depth) % MOD
                         elsif y == 0
                           (x * 16_807 + @depth) % MOD
                         else
                           (@erosion[x - 1][y] * @erosion[x][y - 1] + @depth) % MOD
                         end
      end
    end
  end

  def type(x, y)
    return -1 if x < 0 || y < 0 || x >= @erosion.size || y >= @erosion[x].size
    return 0 if @target == [x, y]

    (@erosion[x][y] % MOD) % 3
  end

  def s_type(x, y)
    case type(x, y)
    when 0 then '.'
    when 1 then '='
    when 2 then '|'
    else 'X'
    end
  end

  def print!
    (0..@target[1]).each do |y|
      (0..@target[0]).each do |x|
        print s_type(x, y)
      end
      puts ''
    end
  end

  def part1
    s = 0
    (0..@target[0]).each do |x|
      (0..@target[1]).each do |y|
        s += type(x, y)
      end
    end
    s
  end

  def part2
    queue = PriorityQueue.new

    # Objects:
    # 0 = neither: wet (1), narrow (2)
    # 1 = torch: rocky (0), narrow(2)
    # 2 = climbing: rocky (0), wet (1)

    queue << [0, 1, 0, 0] # time, object, x, y
    viewed = { [1, 0, 0] => 0 } # object, x, y => time

    until queue.empty?
      e = queue.pop

      time, o, x, y = e

      return time if [o, x, y] == [1, *@target]

      [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |n|
        t = type(*n)
        next if t == -1
        next if t == o

        el = [time + 1, e[1], n[0], n[1]]
        next if viewed[el[1..]] && viewed[el[1..]] <= time + 1

        queue << el
        viewed[el[1..]] = time + 1
      end

      OBJECTS.each do |obj|
        next if obj == type(x, y)

        el = [time + 7, obj, x, y]
        next if viewed[el[1..]] && viewed[el[1..]] <= time + 7

        queue << el
        viewed[el[1..]] = time + 7
      end
    end
  end
end
