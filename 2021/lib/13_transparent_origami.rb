# frozen_string_literal: true

class TransparentOrigami
  def initialize(input)
    @input = input
    @dots = []
    @instructions = []

    @input.split("\n").each do |line|
      case line
      when /^\d+,\d+$/
        @dots << line.split(',').map(&:to_i)
      when /^fold along ([xy])=(\d+)$/
        @instructions << [Regexp.last_match(1), Regexp.last_match(2).to_i]
      end
    end
  end

  def fold_x(x)
    @dots.each do |dot|
      dot[0] = (2 * x) - dot[0] if dot[0] > x
    end
  end

  def fold_y(y)
    @dots.each do |dot|
      dot[1] = (2 * y) - dot[1] if dot[1] > y
    end
  end

  def perform(instruction)
    case instruction[0]
    when 'x' then fold_x(instruction[1])
    when 'y' then fold_y(instruction[1])
    end
  end

  def print!
    xrange = (0..@dots.map(&:first).max)
    yrange = (0..@dots.map(&:last).max)
    dots = @dots.tally
    yrange.each do |y|
      xrange.each do |x|
        print dots.key?([x, y]) ? '#' : ' '
      end
      puts ''
    end
  end

  def part1
    perform(@instructions.first)
    @dots.uniq!
    @dots.size
  end

  def part2
    @instructions.each { perform(_1) }
    print!
  end
end
