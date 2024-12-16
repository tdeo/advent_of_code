# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class RestroomRedoubt
  extend T::Sig

  class Robot
    extend T::Sig

    sig { params(input: String, width: Integer, height: Integer).void }
    def initialize(input, width:, height:)
      matched = input.match(/^p=(\d+),(\d+) v=(-?\d+),(-?\d+)$/)
      @x = T.let(T.must(matched)[1].to_i, Integer)
      @y = T.let(T.must(matched)[2].to_i, Integer)
      @vx = T.let(T.must(matched)[3].to_i, Integer)
      @vy = T.let(T.must(matched)[4].to_i, Integer)
      @width = width
      @height = height
    end

    sig { params(steps: Integer).returns([Integer, Integer]) }
    def pos(steps)
      x = (@x + (steps * @vx)) % @width
      y = (@y + (steps * @vy)) % @height

      [(x + @width) % @width, (y + @height) % @height]
    end

    sig { params(steps: Integer).returns(Symbol) }
    def quadrant(steps)
      x, y = pos(steps)

      case 2 * x
      when @width - 1
        :none
      when 0...@width
        case 2 * y
        when @height - 1
          :none
        when 0...@height
          :topleft
        else
          :bottomleft
        end
      else
        case 2 * y
        when @height - 1
          :none
        when ...@height
          :topright
        else
          :bottomright
        end
      end
    end
  end

  sig { params(input: String, width: Integer, height: Integer).void }
  def initialize(input, width: 101, height: 103)
    @input = input
    @width = width
    @height = height
    @robots = T.let(
      input.split("\n").map do |line|
        Robot.new(line, width: width, height: height)
      end,
      T::Array[Robot],
    )
  end

  sig { returns(Integer) }
  def part1
    pos = @robots.map { _1.quadrant(100) }.tally
    (pos[:bottomright] || 1) * (pos[:bottomleft] || 1) * (pos[:topright] || 1) * (pos[:topleft] || 1)
  end

  sig { params(steps: Integer).void }
  def display!(steps)
    map = T.let(Array.new(@width) { ' ' * @height }, T::Array[String])
    @robots.each do |robot|
      x, y = robot.pos(steps)

      T.must(map[x])[y] = '.'
    end
    puts "\n\n\n"
    puts map.join("\n")
    puts steps
  end

  sig { void }
  def part2
    (0..).find do |i|
      largest_line = @robots.map { |robot| robot.pos(i)[0] }.tally.values.max
      largest_col = @robots.map { |robot| robot.pos(i)[1] }.tally.values.max
      next unless T.must(largest_line) >= @width / 4 && T.must(largest_col) >= @height / 4

      display!(i)
    end
  end
end
