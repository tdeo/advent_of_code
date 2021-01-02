# frozen_string_literal: true

class DockingData
  def initialize(input)
    @input = input
    @instructions = @input.strip.split("\n")
    @mem = {}
    @mask = 'X' * 36
  end

  def apply_mask(val)
    bin = val.to_i.to_s(2).rjust(36, '0')

    (0...bin.size).each do |i|
      bin[-i] = @mask[-i] if @mask[-i] != 'X'
    end

    bin.to_i(2)
  end

  def perform(instruction)
    case instruction
    when /^mask = (.*)/
      @mask = $1
    when /^mem\[(\d+)\] = (.*)/
      @mem[$1] = apply_mask($2)
    end
  end

  def part1
    @instructions.each { perform _1 }
    @mem.values.sum
  end

  def indices(value, mask = @mask)
    if mask.empty?
      yield value
    elsif mask[-1] == '0'
      indices(value, mask[0..-2]) { yield _1 }
    elsif mask[-1] == '1'
      indices(value.dup.tap { _1[mask.size - 1] = '1' }, mask[0..-2]) { yield _1 }
    elsif mask[-1] == 'X'
      indices(value.dup.tap { _1[mask.size - 1] = '0' }, mask[0..-2]) { yield _1 }
      indices(value.dup.tap { _1[mask.size - 1] = '1' }, mask[0..-2]) { yield _1 }
    else
      raise "Invalid mask char #{mask[-1]}"
    end
  end

  def perform2(instruction)
    case instruction
    when /^mask = (.*)/
      @mask = $1
    when /^mem\[(\d+)\] = (.*)/
      indices($1.to_i.to_s(2).rjust(36, '0')) do |idx|
        @mem[idx.to_i] = $2.to_i
      end
    end
  end

  def part2
    @instructions.each { perform2 _1 }
    @mem.values.sum
  end
end
