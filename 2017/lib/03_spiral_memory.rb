class SpiralMemory
  def directions
    [
      [1, 0], # right
      [0, 1], # up
      [-1, 0], # left
      [0, -1], # bottom
    ]
  end

  def initialize(input)
    @target = input.to_i
    @seq = Hash.new { |h,k| h[k] = {} }
    @seq[0][0] = 1
    @x = 0
    @y = 0
    @current_direction = -1
  end

  def set(val)
    @seq[@x][@y] = val
  end

  def sum_adjacents
    (-1..1).flat_map { |i| (-1..1).map { |j| @seq[@x + i][@y + j] || 0 } }.reduce(0, :+)
  end

  def next_case!
    next_dir = (@current_direction + 1) % directions.size
    next_x = @x + directions[next_dir][0]
    next_y = @y + directions[next_dir][1]
    @x, @y = if @seq[next_x][next_y].nil?
               @current_direction = next_dir
               [next_x, next_y]
             else
               [@x + directions[@current_direction][0], @y + directions[@current_direction][1]]
             end
  end

  def part1
    i = 2
    while i <= @target
      next_case!
      set(i)
      i += 1
    end
    @x.abs + @y.abs
  end

  def part2
    loop do
      next_case!
      i = sum_adjacents
      return i if i > @target
      set(i)
    end
  end

  def pp
    x_max = @seq.keys.max
    x_min = @seq.keys.min
    y_max = @seq.map { |_, l| l.keys.max }.compact.max
    y_min = @seq.map { |_, l| l.keys.min }.compact.min

    y_max.downto(y_min) do |y|
      x_min.upto(x_max) do |x|
        print @seq[x][y].to_s.rjust(7)
      end
      puts ''
    end
    puts ''
  end
end
