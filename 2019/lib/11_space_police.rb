# frozen_string_literal: true

require_relative 'intcode'

DIRS = [[-1, 0], [0, -1], [1, 0], [0, 1]].freeze

TURNS = {
  [-1, 0] => [[0, -1], [0, 1]],
  [1, 0] => [[0, 1], [0, -1]],
  [0, 1] => [[-1, 0], [1, 0]],
  [0, -1] => [[1, 0], [-1, 0]],
}.freeze

class SpacePolice
  def initialize(input)
    @input = input
    @panels = Hash.new(0)
    @robot = [0, 0]
    @dir = [-1, 0]
    @intcode = Intcode.new(@input)
  end

  def step
    @intcode.sendint(@panels[@robot])
    @intcode.run_until_input
    color = @intcode.getint
    return nil if color.nil?

    turn = @intcode.getint

    @panels[@robot.dup] = color

    new_dir = DIRS.index(@dir)
    new_dir += turn == 0 ? 1 : -1
    new_dir += 4
    new_dir %= 4
    @dir = DIRS[new_dir]

    @robot[0] += @dir[0]
    @robot[1] += @dir[1]
    true
  end

  def print_map
    @panels[@robot]
    mini, maxi = @panels.keys.map(&:first).minmax
    minj, maxj = @panels.keys.map(&:last).minmax

    ((mini - 1)..(maxi + 1)).each do |i|
      ((minj - 1)..(maxj + 1)).each do |j|
        if @robot == [i, j]
          print 'R'
        else
          print @panels[[i, j]] == 1 ? '#' : ' '
        end
      end
      puts ''
    end
  end

  def part1
    step until @intcode.finished?

    @panels.size
  end

  def part2
    @panels[[0, 0]] = 1
    part1
    print_map
    ''
  end
end
