# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class TuningTrouble
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
  end

  sig { params(count: Integer).returns(Integer) }
  def part1(count = 4)
    @input.each_char.each_cons(count).with_index do |chars, i|
      next unless chars.combination(2).all? { |a, b| a != b }

      return i + count
    end
    0
  end

  sig { returns(Integer) }
  def part2
    part1(14)
  end
end
