# frozen_string_literal: true

class TuringLock
  def initialize(input)
    @instructions = input.split("\n")
    @registers = { 'a' => 0, 'b' => 0 }
    @idx = 0
  end

  def step!
    tokens = @instructions[@idx].tr(',', '').split
    case tokens[0]
    when 'hlf'
      @registers[tokens[1]] /= 2
    when 'tpl'
      @registers[tokens[1]] *= 3
    when 'inc'
      @registers[tokens[1]] += 1
    when 'jmp'
      @idx += tokens[1].to_i - 1
    when 'jie'
      @idx += tokens[2].to_i - 1 if @registers[tokens[1]].even?
    when 'jio'
      @idx += tokens[2].to_i - 1 if @registers[tokens[1]] == 1
    end
    @idx += 1
  end

  def part1
    step! while @idx < @instructions.size
    @registers['b']
  end

  def part2
    @registers['a'] = 1
    part1
  end
end
