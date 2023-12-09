# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class GearRatios
  extend T::Sig

  class Part < T::Struct
    extend T::Sig
    prop :row, Integer
    prop :col, Integer
    prop :value, Integer
    prop :size, Integer
    prop :input, T::Array[String]

    sig { returns(T::Boolean) }
    def valid?
      (row - 1..row + 1).any? do |r|
        next if r < 0
        next if r >= @input.size

        (col - 1..col + size).any? do |c|
          next if c < 0
          next if c >= T.must(@input[r]).size

          neighbour = T.must(T.must(@input[r])[c])
          next if neighbour == '.'
          next if neighbour.match?(/\d/)

          true
        end
      end
    end

    sig { params(_blk: T.proc.params(args: [Integer, Integer]).void).void }
    def gears(&_blk)
      (row - 1..row + 1).any? do |r|
        next if r < 0
        next if r >= @input.size

        (col - 1..col + size).any? do |c|
          next if c < 0
          next if c >= T.must(@input[r]).size

          neighbour = T.must(T.must(@input[r])[c])

          yield [r, c] if neighbour == '*'
        end
      end
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = T.let(input.split("\n"), T::Array[String])
    @parts = T.let([], T::Array[Part])
    @input.each_with_index do |line, row|
      line.scan(/\d+/) do |val|
        value = T.cast(val, String)
        @parts << Part.new(
          input: @input,
          row: row,
          col: T.must(Regexp.last_match).pre_match.size,
          value: value.to_i,
          size: value.size,
        )
      end
    end
  end

  sig { returns(Integer) }
  def part1
    @parts.select(&:valid?).sum(&:value)
  end

  sig { returns(Integer) }
  def part2
    gears = T.let(
      Hash.new { |h, k| h[k] = [] },
      T::Hash[[Integer, Integer], T::Array[Integer]],
    )
    @parts.each do |part|
      part.gears do |g|
        T.must(gears[g]) << part.value
      end
    end
    gears.each_value.sum do |neighbours|
      next 0 if neighbours.size != 2

      T.must(neighbours.first) * T.must(neighbours.last)
    end
  end
end
