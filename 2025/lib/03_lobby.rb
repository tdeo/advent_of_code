# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Lobby
  extend T::Sig

  class BatteryBank
    extend T::Sig

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      @values = T.let(input.chars, T::Array[String])
    end

    sig { params(count: Integer).returns(Integer) }
    def best_joltage(count)
      current = []
      remainder = @values.dup
      count.downto(1).each do |i|
        best_value = remainder[..-i]&.max
        current << best_value
        idx = T.must(remainder.index(best_value))
        remainder.slice!(0, idx + 1)
      end
      current.join.to_i
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @battery_banks = T.let(input.lines(chomp: true).map { BatteryBank.new(_1) }, T::Array[BatteryBank])
  end

  sig { params(count: Integer).returns(Integer) }
  def part1(count = 2)
    @battery_banks.sum { _1.best_joltage(count) }
  end

  sig { returns(Integer) }
  def part2
    part1(12)
  end
end
