# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class SecretEntrance
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @instructions = T.let(input.lines(chomp: true).map { Instruction.new(_1) }, T::Array[Instruction])
    @position = T.let(50, Integer)
  end

  class Instruction
    extend T::Sig

    class Direction < T::Enum
      extend T::Sig

      enums do
        L = new(:L)
        R = new(:R)
      end

      sig { returns(String) }
      def inspect
        serialize.to_s
      end
    end

    sig { returns(Direction) }
    attr_reader :direction

    sig { returns(Integer) }
    attr_reader :distance

    sig { params(input: String).void }
    def initialize(input)
      direction = T.must(input[0]).to_sym
      @direction = T.let(Direction.deserialize(direction), Direction)
      @distance = T.let(input[1..].to_i, Integer)
    end

    sig { returns(String) }
    def inspect
      "#{direction} #{distance}"
    end
  end

  sig { params(instruction: Instruction).void }
  def apply!(instruction)
    case instruction.direction
    when Instruction::Direction::L
      @position -= instruction.distance
    when Instruction::Direction::R
      @position += instruction.distance
    end
  end

  sig { returns(Integer) }
  def part1
    count = 0
    @instructions.each do |instruction|
      apply!(instruction)
      count += 1 if @position % 100 == 0
    end
    count
  end

  sig { returns(Integer) }
  def part2
    count = 0
    @instructions.each do |instruction|
      @position = ((@position % 100) + 100) % 100
      @position = 100 if @position == 0 && instruction.direction == Instruction::Direction::L
      count += (instruction.distance + 100 - @position) / 100 if instruction.direction == Instruction::Direction::L
      count += (instruction.distance + @position) / 100 if instruction.direction == Instruction::Direction::R
      apply!(instruction)
    end
    count
  end
end
