# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CosmicExpansion
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @galaxies = T.let([], T::Array[[Integer, Integer]])
    @busy_cols = T.let(Set.new, T::Set[Integer])
    @input.each_line(chomp: true).with_index do |row, i|
      row.each_char.with_index do |c, j|
        @galaxies << [i, j] if c == '#'
      end
    end
    @busy_rows = T.let(@galaxies.to_set(&:first), T::Set[Integer])
    @busy_cols = T.let(@galaxies.to_set(&:last), T::Set[Integer])
    @dilation = T.let(2, Integer)
  end

  sig { params(a: [Integer, Integer], b: [Integer, Integer]).returns(Integer) }
  def dist(a, b)
    i0, i1 = [a[0], b[0]].minmax
    j0, j1 = [a[1], b[1]].minmax

    T.must(i1) - T.must(i0) +
      T.must(j1) - T.must(j0) +
      ((@dilation - 1) * (i0..i1).count { !@busy_rows.include?(_1) }) +
      ((@dilation - 1) * (j0..j1).count { !@busy_cols.include?(_1) })
  end

  sig { returns(Integer) }
  def part1
    @galaxies.combination(2).sum { |a, b| dist(T.must(a), T.must(b)) }
    @galaxies.combination(2).sum { |a, b| dist(T.must(a), T.must(b)) }
  end

  sig { returns(Integer) }
  def part2
    @dilation = 1_000_000
    part1
  end
end
