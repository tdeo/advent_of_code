# frozen_string_literal: true

require_relative 'intcode'

class SetandForget
  def initialize(input)
    @input = input
    @intcode = Intcode.new(@input)
  end

  def generate_map!
    @map = ''
    @intcode.run
    @map += @intcode.getint.chr while @intcode.output?
    @map = @map.strip.split("\n")
    @height = @map.size
    @width = @map[0].size
  end

  def part1
    s = 0
    generate_map!
    (1...(@height - 1)).each do |i|
      (1...(@width - 1)).each do |j|
        next unless @map[i][j] == '#' &&
                    @map[i + 1][j] == '#' &&
                    @map[i - 1][j] == '#' &&
                    @map[i][j + 1] == '#' &&
                    @map[i][j - 1] == '#'

        s += i * j
      end
    end
    s
  end

  def find_robot
    robots = %w[^ < > v]
    (0...@height).each do |i|
      (0...@width).each do |j|
        return [i, j] if robots.include?(@map[i][j])
      end
    end
  end

  def turn_right(dir)
    { U: :R, R: :D, D: :L, L: :U }[dir]
  end

  def turn_left(dir)
    { U: :L, L: :D, D: :R, R: :U }[dir]
  end

  def move(dir)
    { U: [-1, 0], D: [1, 0], L: [0, -1], R: [0, 1] }[dir]
  end

  def at(pos)
    return nil if pos[0] < 0 || pos[1] < 0 || pos[0] >= @height || pos[1] >= @width

    @map[pos[0]][pos[1]]
  end

  def plus(pos, dir)
    m = move(dir)
    [pos[0] + m[0], pos[1] + m[1]]
  end

  def append(dir)
    if @path[-1] && @path[-1][0] == dir
      @path[-1][1] += 1
    else
      @path << [dir, 1]
    end
  end

  def move!
    @robot = plus(@robot, @dir)
  end

  def part2
    generate_map!
    @robot = find_robot
    @dir = {
      '^' => :U,
      'v' => :D,
      '>' => :R,
      '<' => :L,
    }[@map[@robot[0]][@robot[1]]]
    @path = [[@dir, 0]]

    loop do
      if at(plus(@robot, @dir)) == '#'
        append(@dir)
        move!
      elsif at(plus(@robot, turn_right(@dir))) == '#'
        @dir = turn_right(@dir)
        append(@dir)
        move!
      elsif at(plus(@robot, turn_left(@dir))) == '#'
        @dir = turn_left(@dir)
        append(@dir)
        move!
      else
        break
      end
    end

    clean = []
    (1...@path.size).each do |i|
      if turn_right(@path[i - 1][0]) == @path[i][0]
        clean << 'R'
      elsif turn_left(@path[i - 1][0]) == @path[i][0]
        clean << 'L'
      else
        raise 'Cannot turn like that!'
      end
      clean << @path[i][1]
    end
    final_path = clean.join(',')
    a = 'R,8,L,10,L,12,R,4'
    b = 'R,8,L,12,R,4,R,4'
    c = 'R,8,L,10,R,8'
    puts final_path
    final_path.gsub!(a, 'A')
    final_path.gsub!(b, 'B')
    final_path.gsub!(c, 'C')
    puts final_path

    intcode = Intcode.new(@input)
    intcode.set(0, 2)
    [final_path, a, b, c, 'n'].each do |line|
      line.each_char { |ch| intcode.sendint(ch.ord) }
      intcode.sendint("\n".ord)
    end
    intcode.run
    a = nil
    a = intcode.getint while intcode.output?
    a
  end
end
