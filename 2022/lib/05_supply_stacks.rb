# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

class SupplyStacks
  extend T::Sig

  class Instruction < T::Struct
    prop :count, Integer
    prop :from, Integer
    prop :to, Integer
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @stacks = T.let([], T::Array[T::Array[String]])
    stacks, instructions = @input.split(/\n[\s\d]+\n/)
    T.must(stacks).split("\n").each do |line|
      break if line.start_with?(' 1')

      idx = 1
      while idx < line.size
        (@stacks[idx / 4] ||= []).unshift(T.must(line[idx])) if line[idx] != ' '
        idx += 4
      end
    end
    @instructions = T.let(T.must(instructions).split("\n").map do |line|
      r = T.must(line.match(/move (\d+) from (\d+) to (\d+)/))
      Instruction.new(
        count: r[1].to_i,
        from: r[2].to_i - 1,
        to: r[3].to_i - 1,
      )
    end, T::Array[Instruction],)
  end

  sig { void }
  def debug
    @stacks.each { puts _1.inspect }
  end

  sig { returns(String) }
  def part1
    @instructions.each do |ins|
      @stacks[ins.to] = T.must(@stacks[ins.to]) + T.must(@stacks[ins.from]).pop(ins.count).reverse
    end
    @stacks.map(&:last).join
  end

  sig { returns(String) }
  def part2
    @instructions.each do |ins|
      @stacks[ins.to] = T.must(@stacks[ins.to]) + T.must(@stacks[ins.from]).pop(ins.count)
    end
    @stacks.map(&:last).join
  end
end
