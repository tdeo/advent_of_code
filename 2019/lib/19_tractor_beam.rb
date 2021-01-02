# frozen_string_literal: true

require_relative 'intcode'

class TractorBeam
  def initialize(input)
    @input = input
  end

  def laser?(x, y)
    intcode = Intcode.new(@input).sendint(x).sendint(y)
    intcode.run
    intcode.getint == 1
  end

  def part1
    c = 0
    (0...50).each do |i|
      (0...50).each do |j|
        c += 1 if laser?(i, j)
      end
    end
    c
  end

  def print!
    (0...50).each do |y|
      (0...50).each do |x|
        print laser?(x, y) ? 'X' : '.'
      end
      puts ''
    end
  end

  def part2
    b = [0, 10]
    loop do
      b[0] += 1 until laser?(*b)
      return 10_000 * b[0] + (b[1] - 99) if laser?(b[0] + 99, b[1] - 99)

      b[1] += 1
    end
  end
end
