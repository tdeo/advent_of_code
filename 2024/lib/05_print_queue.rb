# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class PrintQueue
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @rules = T.let(Set.new, T::Set[[Integer, Integer]])
    @blocks = T.let([], T::Array[T::Array[Integer]])
    @input.each_line(chomp: true) do |line|
      if line.include?('|')
        first, second = line.split('|').map(&:to_i)
        @rules << [T.must(first), T.must(second)]
      elsif line.include?(',')
        @blocks << line.split(',').map(&:to_i)
      end
    end
  end

  sig { params(block: T::Array[Integer]).returns(T::Boolean) }
  def valid?(block)
    indices = block.each_with_index.to_h { |a, b| [a, b] }
    @rules.all? do |a, b|
      (indices[a] || - 1) < (indices[b] || block.size)
    end
  end

  sig { returns(Integer) }
  def part1
    @blocks.sum do |block|
      next 0 unless valid?(block)

      block[block.size / 2] || 0
    end
  end

  sig { params(block: T::Array[Integer]).void }
  def sort!(block)
    block.sort! do |a, b|
      next 0 if a == b
      next -1 if @rules.include?([a, b])
      next 1 if @rules.include?([b, a])

      raise
    end
  end

  sig { returns(Integer) }
  def part2
    @blocks.sum do |block|
      next 0 if valid?(block)

      sort!(block)
      block[block.size / 2] || 0
    end
  end
end
