require_relative 'intcode'

DIRS = [[-1, 0], [0, -1], [1, 0], [0, 1]]

TURNS = {
  [-1, 0] => [ [0, -1], [0, 1] ],
  [1, 0] => [ [0, 1], [0, -1] ],
  [0, 1] => [ [-1, 0], [1, 0] ],
  [0, -1] => [ [1, 0], [-1, 0] ],
}

class SpacePolice
  def initialize(input)
    @input = input
    @panels = Hash.new { |h, k| h[k] = Hash.new(0) }
    @robot = [0, 0]
    @dir = [-1, 0]
    @intcode = Intcode.new(@input)
    @painted = {}
  end

  def step
    @intcode.sendint(@panels[@robot[0]][@robot[1]])
    @intcode.run_until_input
    color = @intcode.getint

    @painted[@robot] = true

    @panels[@robot[0]][@robot[1]] = color
    turn = @intcode.getint

    new_dir = DIRS.index(@dir)
    new_dir += (turn == 0) ? 1 : -1
    new_dir += 4
    new_dir = new_dir % 4
    @dir = DIRS[new_dir]

    @robot[0] += @dir[0]
    @robot[1] += @dir[1]
  end

  def print_map
    @panels[@robot[0]][@robot[1]]
    mini, maxi = @panels.keys.minmax
    minj, maxj = @panels.values.flat_map(&:keys).minmax

    (mini..maxi).each do |i|
      (minj..maxj).each do |j|
        if @robot == [i, j]
          print 'R'
        else
          print @panels[i][j] == 1 ? ?# : ?.
        end
      end
      puts ''
    end
  end

  def part1
    count = 0
    while !@intcode.finished? do
      count += 1
      step
      # print_map
      # break if count > 10
    end

    print_map

    @painted.size
  end

  def part2
  end
end
