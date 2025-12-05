# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Cafeteria
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    ranges, ingredients = input.split("\n\n")
    @ranges = T.let(T.must(ranges).lines(chomp: true).map do |range|
      min, max = range.split('-').map(&:to_i).minmax
      Range.new(T.must(min), T.must(max))
    end, T::Array[T::Range[Integer]],)
    @ingredients = T.let(T.must(ingredients).lines(chomp: true).map(&:to_i), T::Array[Integer])
  end

  sig { returns(Integer) }
  def part1
    @ingredients.count { |i| @ranges.any? { _1.include?(i) } }
  end

  sig { returns(Integer) }
  def part2
    @ranges.sort_by!(&:min)
    i = 0
    while (second = @ranges[i + 1])
      first = T.must(@ranges[i])
      if second.min <= first.max
        @ranges[i] = ::Range.new(first.min, [first.max, second.max].max)
        @ranges.delete_at(i + 1)
      else
        i += 1
      end
    end
    T.must(@ranges.sum(&:size))
  end
end
