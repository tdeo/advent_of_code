# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MonkeyMarket
  extend T::Sig

  MOD = 16_777_216

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @numbers = T.let(input.lines(chomp: true).map(&:to_i), T::Array[Integer])
  end

  sig { params(number: Integer).returns(Integer) }
  def succ(number)
    number ^= (number << 6)
    number %= MOD

    number ^= (number >> 5)
    number %= MOD

    number ^= (number << 11)
    number % MOD
  end

  sig { returns(Integer) }
  def part1
    @numbers.sum do |num|
      a = num
      2000.times { a = succ(a) }
      a
    end
  end

  Changes = T.type_alias { [Integer, Integer, Integer, Integer] }

  sig { params(seed: Integer).returns(T::Hash[Changes, Integer]) }
  def money_from(seed)
    gains = T.let({}, T::Hash[Changes, Integer])
    last_changes = T.let([-10, -10, -10, -10], Changes)
    price = seed

    2000.times do
      next_price = succ(price)

      last_changes = [last_changes[1], last_changes[2], last_changes[3], (next_price % 10) - (price % 10)]
      price = next_price
      gains[last_changes] ||= price % 10
    end
    gains
  end

  sig { returns(Integer) }
  def part2
    result = T.let(Hash.new(0), T::Hash[Changes, Integer])
    @numbers.each do |seed|
      money_from(seed).each do |k, v|
        result[k] = T.must(result[k]) + v
      end
    end
    T.must(result.each_value.max)
  end
end
