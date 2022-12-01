# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CalorieCounting
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = T.let(input, String)
    @elves = T.let([[]], T::Array[T::Array[Integer]])
    @input.split("\n").each do |l|
      if l.empty?
        @elves << []
      else
        T.must(@elves.last) << l.to_i
      end
    end
  end

  sig { returns(Integer) }
  def part1
    T.must(@elves.map(&:sum).max)
  end

  sig { returns(Integer) }
  def part2
    @elves.map(&:sum).sort.last(3).sum
  end
end
