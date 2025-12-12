# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class ChristmasTreeFarm
  extend T::Sig

  class Problem
    extend T::Sig

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      dimension, *counts = input.split
      @width = T.let(T.must(dimension).split('x').first.to_i, Integer)
      @height = T.let(T.must(dimension).split('x').last.to_i, Integer)
      @counts = T.let(counts.map(&:to_i), T::Array[Integer])
    end

    sig { returns(Integer) }
    def surface
      @width * @height
    end

    sig { params(block_surfaces: T::Array[Integer]).returns(T::Boolean) }
    def fits?(block_surfaces)
      block_surface = @counts.zip(block_surfaces).sum do |count, block_surface|
        count * T.must(block_surface)
      end
      block_surface <= surface
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    *blocks, problems = input.split("\n\n")
    @blocks = T.let(blocks.map do |block|
      T.must(block.lines(chomp: true)[1..])
    end, T::Array[T::Array[String]],)
    @problems = T.let(T.must(problems).lines(chomp: true).map { Problem.new(_1) }, T::Array[Problem])
    @blocks_surface = T.let(@blocks.map do |block|
      block.join.count('#')
    end, T::Array[Integer],)
  end

  sig { returns(Integer) }
  def part1
    @problems.count { _1.fits?(@blocks_surface) }
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
