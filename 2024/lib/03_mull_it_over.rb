# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MullItOver
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
  end

  sig { returns(Integer) }
  def part1
    @input.scan(/mul\(\d{1,3},\d{1,3}\)/).flatten.sum do |m|
      a, b, = T.must(m[4...-1]).split(',').map(&:to_i)
      a.to_i * b.to_i
    end
  end

  sig { returns(Integer) }
  def part2
    enabled = T.let(true, T::Boolean)
    @input.scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/).flatten.sum do |m|
      if m == 'do()'
        enabled = true
        0
      elsif m == "don't()"
        enabled = false
        0
      elsif enabled
        a, b, = T.must(m[4...-1]).split(',').map(&:to_i)
        a.to_i * b.to_i
      else
        0
      end
    end
  end
end
