# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CodeChronicle
  extend T::Sig

  K = T.type_alias { [Integer, Integer, Integer, Integer, Integer] }
  IDX = T.let([0, 1, 2, 3, 4].freeze, K)

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @keys = T.let([], T::Array[K])
    @locks = T.let([], T::Array[K])
    input.split("\n\n").each do |schema|
      lines = schema.split("\n")
      values = [
        lines.count { _1[0] == '#' } - 1,
        lines.count { _1[1] == '#' } - 1,
        lines.count { _1[2] == '#' } - 1,
        lines.count { _1[3] == '#' } - 1,
        lines.count { _1[4] == '#' } - 1,
      ]
      type = lines[0] == '#####' ? @locks : @keys
      type << values
    end
  end

  sig { returns(Integer) }
  def part1
    @locks.product(@keys).count do |l, k|
      l[0] + k[0] <= 5 &&
        l[1] + k[1] <= 5 &&
        l[2] + k[2] <= 5 &&
        l[3] + k[3] <= 5 &&
        l[4] + k[4] <= 5
    end
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
