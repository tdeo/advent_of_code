# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class HistorianHysteria
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @left = T.let([], T::Array[Integer])
    @right = T.let([], T::Array[Integer])
    @input.each_line(chomp: true) do |line|
      l, r = line.split.map(&:to_i)
      @left << T.must(l)
      @right << T.must(r)
    end
  end

  sig { returns(Integer) }
  def part1
    @left.sort.zip(@right.sort).sum do |a, b|
      (a - T.must(b)).abs
    end
  end

  sig { returns(Integer) }
  def part2
    right = @right.tally
    @left.sum { _1 * (right[_1] || 0) }
  end
end
