# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Scratchcards
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @cards = T.let(
      @input.split("\n").map do |line|
        _, numbers = line.split(': ')

        T.must(numbers).split(' | ').map { _1.split.map(&:to_i) }
      end,
      T::Array[T::Array[T::Array[Integer]]],
    )
  end

  sig { returns(Integer) }
  def part1
    @cards.sum do |card|
      overlap = (T.must(card.first) & T.must(card.last)).size
      overlap == 0 ? 0 : (2**(overlap - 1)).to_i
    end
  end

  sig { returns(Integer) }
  def part2
    counts = @cards.map { 1 }

    @cards.each_with_index do |card, i|
      win_count = (T.must(card.first) & T.must(card.last)).size
      ((i + 1)..(i + win_count)).each do |j|
        counts[j] = T.must(counts[j]) + T.must(counts[i])
      end
    end

    counts.sum
  end
end
