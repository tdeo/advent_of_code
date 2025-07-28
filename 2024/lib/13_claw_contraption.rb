# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class ClawContraption
  extend T::Sig

  class Statement
    extend T::Sig

    sig { params(input: String).void }
    def initialize(input)
      line_a, line_b, line_prize = input.split("\n")
      @a = T.let(
        T.cast(T.must(line_a&.match(/^Button A: X\+(\d+), Y\+(\d+)$/))[1..2].map(&:to_i), [Integer, Integer]),
        [Integer, Integer],
      )
      @b = T.let(
        T.cast(T.must(line_b&.match(/^Button B: X\+(\d+), Y\+(\d+)$/))[1..2].map(&:to_i), [Integer, Integer]),
        [Integer, Integer],
      )
      @prize = T.let(
        T.cast(T.must(line_prize&.match(/^Prize: X=(\d+), Y=(\d+)$/))[1..2].map(&:to_i), [Integer, Integer]),
        [Integer, Integer],
      )
    end

    sig { returns(T.nilable(Integer)) }
    def cheapest
      best = T.let(nil, T.nilable(Integer))
      (0..(@prize[0] / @a[0])).each do |i|
        j = (@prize[0] - (i * @a[0])) / @b[0]
        next unless (i * @a[0]) + (j * @b[0]) == @prize[0]
        next unless (i * @a[1]) + (j * @b[1]) == @prize[1]

        price = (3 * i) + j
        best = price if best.nil? || best > price
      end

      best
    end

    sig { void }
    def part2!
      @prize[0] += 10_000_000_000_000
      @prize[1] += 10_000_000_000_000
    end

    sig { returns(T.nilable(Integer)) }
    def cheapest2
      # solving
      # i * a0 + j * bo = t0 (1)
      # i * a1 + j * b1 = t1 (2)

      # Doing b1 * (1) - b0 (2) yields
      # i * a0 * b1 - i * a1 * b0 = t0 * b1 - t1 * b0
      # i = (t0 * b1 - t1 * b0) / (a0 * b1 - a1 * b0)
      a0, a1 = @a
      b0, b1 = @b
      t0, t1 = @prize
      i = ((t0 * b1) - (t1 * b0)) / ((a0 * b1) - (a1 * b0))
      j = (@prize[0] - (i * @a[0])) / @b[0]

      return unless (i * @a[0]) + (j * @b[0]) == @prize[0]
      return unless (i * @a[1]) + (j * @b[1]) == @prize[1]

      (3 * i) + j
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @statements = T.let(@input.split("\n\n").map { Statement.new(_1) }, T::Array[Statement])
  end

  sig { returns(Integer) }
  def part1
    @statements.sum { _1.cheapest || 0 }
  end

  sig { returns(Integer) }
  def part2
    @statements.each(&:part2!)
    @statements.sum { _1.cheapest2 || 0 }
  end
end
