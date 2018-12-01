class Hex
  def initialize(input)
    @current = [0, 0]
    @moves = input.strip.split(',')
  end

  def apply!(move)
    case move
    when 'n'
      @current[1] += 2
    when 'ne'
      @current[0] += 1
      @current[1] += 1
    when 'se'
      @current[0] += 1
      @current[1] -= 1
    when 's'
      @current[1] -= 2
    when 'sw'
      @current[0] -= 1
      @current[1] -= 1
    when 'nw'
      @current[0] -= 1
      @current[1] += 1
    end
  end

  def distance_to_origin
    x, y = @current.map(&:abs)
    min = [x, y].min
    min + (x - min) / 2 + (y - min) / 2
  end

  def part1
    @moves.each { |m| apply!(m) }
    distance_to_origin
  end

  def part2
    max = 0
    @moves.each do |m|
      apply!(m)
      max = [max, distance_to_origin].max
    end
    max
  end
end
