# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class PlutonianPebbles
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @stones = T.let(input.split.map(&:to_i), T::Array[Integer])
  end

  sig { params(value: Integer, rounds: Integer).returns(Integer) }
  def size_after(value, rounds)
    @size_after ||= T.let({}, T.nilable(T::Hash[[Integer, Integer], Integer]))
    @size_after[[value, rounds]] ||=
      if rounds == 0
        1
      elsif value == 0
        size_after(1, rounds - 1)
      elsif value.to_s.size.even?
        v = value.to_s
        size_after(v[...(v.size / 2)].to_i, rounds - 1) + size_after(v[(v.size / 2)..].to_i, rounds - 1)
      else
        size_after(2024 * value, rounds - 1)
      end
  end

  sig { params(rounds: Integer).returns(Integer) }
  def part1(rounds = 25)
    @stones.sum { size_after(_1, rounds) }
  end

  sig { returns(Integer) }
  def part2
    part1(75)
  end
end
