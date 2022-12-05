# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CampCleanup
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @pairs = T.let([], T::Array[[[Integer, Integer], [Integer, Integer]]])
    @input.split("\n").each do |line|
      a, b = line.split(',')
      amin, amax = T.must(a).split('-')
      bmin, bmax = T.must(b).split('-')
      @pairs << [
        [amin.to_i, amax.to_i],
        [bmin.to_i, bmax.to_i],
      ]
    end
  end

  sig { returns(Integer) }
  def part1
    @pairs.count do |a, b|
      amin, amax = a
      bmin, bmax = b
      (bmin <= amin && bmax >= amax) ||
        (bmin >= amin && bmax <= amax)
    end
  end

  sig { returns(Integer) }
  def part2
    @pairs.count do |a, b|
      amin, amax = a
      bmin, bmax = b
      (bmin <= amax && bmax >= amin) ||
        (bmin >= amax && bmax <= amin)
    end
  end
end
