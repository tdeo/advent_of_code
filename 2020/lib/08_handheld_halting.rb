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

    if op == 'acc'
      @cursor += 1
      @accumulator += value
    elsif op == 'jmp'
      @cursor += value
    elsif op == 'nop'
      @cursor += 1
    else
      fail "Unrecognized operator #{op}"
    end
  end

  def part1
    visited = { @instructions.size => true }

    while !visited.key?(@cursor) do
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
      if ins[0] == 'nop'
        ins[0] = 'jmp'
      elsif ins[0] == 'jmp'
        ins[0] = 'nop'
      end

      part1

      if ins[0] == 'nop'
        ins[0] = 'jmp'
      elsif ins[0] == 'jmp'
        ins[0] = 'nop'
      end

      return @accumulator if @cursor == @instructions.size
    end
  end
end
