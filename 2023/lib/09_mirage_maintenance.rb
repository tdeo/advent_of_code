# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MirageMaintenance
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @series = T.let(@input.each_line(chomp: true).map do |line|
      line.split.map(&:to_i)
    end, T::Array[T::Array[Integer]],)
  end

  sig { params(serie: T::Array[Integer]).returns(Integer) }
  def next_val(serie)
    last_digits = T.let([], T::Array[Integer])

    until serie.all?(&:zero?)
      last_digits << T.must(serie.last)
      serie = serie.each_cons(2).map { |a, b| T.must(b) - T.must(a) }
    end

    res = 0
    res += T.must(last_digits.pop) until last_digits.empty?
    res
  end

  sig { returns(Integer) }
  def part1
    @series.sum { next_val(_1) }
  end

  sig { params(serie: T::Array[Integer]).returns(Integer) }
  def prev_val(serie)
    first_digits = T.let([], T::Array[Integer])

    until serie.all?(&:zero?)
      first_digits << T.must(serie.first)
      serie = serie.each_cons(2).map { |a, b| T.must(b) - T.must(a) }
    end

    res = 0
    res = T.must(first_digits.pop) - res until first_digits.empty?
    res
  end

  sig { returns(Integer) }
  def part2
    @series.sum { prev_val(_1) }
  end
end
