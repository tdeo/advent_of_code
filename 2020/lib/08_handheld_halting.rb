# frozen_string_literal: true

class HandheldHalting
  def initialize(input)
    @input = input
    @instructions = @input.each_line.map do |line|
      op, val = line.split
      [op, val.to_i]
    end
    @accumulator = 0
    @cursor = 0
  end

  def execute(instruction)
    op, value = instruction

    case op
    when 'acc'
      @cursor += 1
      @accumulator += value
    when 'jmp'
      @cursor += value
    when 'nop'
      @cursor += 1
    else
      raise "Unrecognized operator #{op}"
    end
  end

  def part1
    visited = { @instructions.size => true }

    until visited.key?(@cursor)
      visited[@cursor] = true
      execute(@instructions[@cursor])
    end

    @accumulator
  end

  def reset!
    @accumulator = 0
    @cursor = 0
  end

  def part2
    @instructions.each do |ins|
      reset!
      case ins[0]
      when 'nop'
        ins[0] = 'jmp'
      when 'jmp'
        ins[0] = 'nop'
      end

      part1

      case ins[0]
      when 'nop'
        ins[0] = 'jmp'
      when 'jmp'
        ins[0] = 'nop'
      end

      return @accumulator if @cursor == @instructions.size
    end
  end
end
