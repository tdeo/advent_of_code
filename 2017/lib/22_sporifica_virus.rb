# frozen_string_literal: true

class SporificaVirus
  def initialize(input)
    @position = [0, 0] # row, column towards bottom and right
    @direction = :up
    @nodes = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = 0 } }
    input.split("\n").each_with_index do |line, i|
      line.chars.each_with_index do |c, j|
        @nodes[i][j] = case c
                       when '#' then 1
                       when 'F' then 2
                       when 'W' then 3
                       when '.' then 0
                       end
      end
    end
    @position = [input.split("\n").size / 2, input.split("\n").first.size / 2]
    @infections = 0
  end

  def move!
    case @direction
    when :right then @position[1] += 1
    when :left then @position[1] -= 1
    when :up then @position[0] -= 1
    when :down then @position[0] += 1
    end
  end

  def turn!
    case @nodes[@position[0]][@position[1]]
    when 1 # infected, turn right
      case @direction
      when :up then @direction = :right
      when :right then @direction = :down
      when :down then @direction = :left
      when :left then @direction = :up
      end
    when 0 # clean, turn left
      case @direction
      when :right then @direction = :up
      when :down then @direction = :right
      when :left then @direction = :down
      when :up then @direction = :left
      end
    when 2 # flagged, turn around
      case @direction
      when :right then @direction = :left
      when :left then @direction = :right
      when :up then @direction = :down
      when :down then @direction = :up
      end
    when 3
      # weakened, do nothing
    end
  end

  def burst1!
    turn!
    if @nodes[@position[0]][@position[1]] == 1
      @nodes[@position[0]][@position[1]] = 0
    else
      @infections += 1
      @nodes[@position[0]][@position[1]] = 1
    end
    move!
  end

  def part1
    10_000.times { burst1! }
    @infections
  end

  def burst2!
    turn!
    @nodes[@position[0]][@position[1]] =
      case @nodes[@position[0]][@position[1]]
      when 0 then 3
      when 3
        @infections += 1
        1
      when 1 then 2
      when 2 then 0
      end
    move!
  end

  def part2
    10_000_000.times { burst2! }
    @infections
  end
end
