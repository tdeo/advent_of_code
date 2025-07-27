# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Aplenty
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
  end

  sig { returns(Integer) }
  def part1
    0
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
