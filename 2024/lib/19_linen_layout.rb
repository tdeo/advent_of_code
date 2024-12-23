# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class LinenLayout
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    towels, patterns = input.split("\n\n")
    @towels = T.let(T.must(towels).split(', '), T::Array[String])
    @patterns = T.let(T.must(patterns).lines(chomp: true), T::Array[String])
  end

  sig { params(pattern: String).returns(T::Boolean) }
  def possible?(pattern)
    return true if pattern.empty?

    @towels.any? { pattern.start_with?(_1) && possible?(pattern.delete_prefix(_1)) }
  end

  sig { returns(Integer) }
  def part1
    @patterns.count { possible?(_1) }
  end

  sig { params(pattern: String).returns(Integer) }
  def options(pattern)
    @options ||= T.let({ '' => 1 }, T.nilable(T::Hash[String, Integer]))

    @options[pattern] ||= @towels.sum do |start|
      next 0 unless pattern.start_with?(start)

      options(pattern.delete_prefix(start))
    end
  end

  sig { returns(Integer) }
  def part2
    @patterns.sum { options(_1) }
  end
end
