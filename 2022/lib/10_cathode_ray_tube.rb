# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CathodeRayTube
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @values = T.let([1, 1], T::Array[Integer])
    @instructions = T.let(input.split("\n"), T::Array[String])
  end

  sig { params(instruction: String).void }
  def perform(instruction)
    operator, *rest = instruction.split
    case operator
    when 'noop' then @values << T.must(@values[-1])
    when 'addx'
      @values << T.must(@values[-1])
      @values << (T.must(@values[-1]) + rest[0].to_i)
    else raise ArgumentError, instruction
    end
  end

  sig { returns(Integer) }
  def part1
    @instructions.each do |ins|
      perform(ins)
    end
    (20..220).step(40).sum do |i|
      T.must(@values[i]) * i
    end
  end

  sig { void }
  def part2
    @instructions.each do |ins|
      perform(ins)
    end

    output = (1..240).map do |i|
      (((i - 1) % 40) - @values[i].to_i).abs <= 1 ? '#' : ' '
    end

    (0..220).step(40).each do |i|
      puts T.must(output[i...(i + 40)]).join
    end
  end
end
