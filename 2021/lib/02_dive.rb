# frozen_string_literal: true

class Dive
  def initialize(input)
    @input = input
    @instructions = input.split("\n").map { _1.split }
    @depth = 0
    @horizontal = 0
  end

  def process(instruction)
    case instruction[0]
    when 'forward' then @horizontal += instruction[1].to_i
    when 'down' then @depth += instruction[1].to_i
    when 'up' then @depth -= instruction[1].to_i
    end
  end

  def part1
    @instructions.each { process(_1) }
    @depth * @horizontal
  end

  def process2(instruction)
    case instruction[0]
    when 'forward'
      @horizontal += instruction[1].to_i
      @depth += @aim * instruction[1].to_i
    when 'down' then @aim += instruction[1].to_i
    when 'up' then @aim -= instruction[1].to_i
    end
  end

  def part2
    @aim = 0
    @instructions.each { process2(_1) }
    @depth * @horizontal
  end
end
