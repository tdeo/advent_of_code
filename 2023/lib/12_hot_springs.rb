# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class HotSprings
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @problems = T.let(@input.each_line(chomp: true).map do |line|
      pattern, count = line.split

      [T.must(pattern), T.must(count).split(',').map(&:to_i)]
    end, T::Array[[String, T::Array[Integer]]],)
    @memo = T.let({}, T::Hash[[String, T::Array[Integer]], Integer])
  end

  sig { params(pattern: String, target: T::Array[Integer]).returns(Integer) }
  def options(pattern, target)
    return T.must(@memo[[pattern, target]]) if @memo.key?([pattern, target])

    if target.empty?
      return 0 if pattern.include?('#')

      return 1
    end

    return 0 if pattern.size < target.sum + target.size - 1

    r = 0
    if !T.must(pattern[-T.must(target.last)..]).include?('.') && (pattern[-T.must(target.last) - 1] || '.') != '#'
      r += options(T.must(pattern[...(-T.must(target.last) - 1)]), T.must(target[...-1]))
    end
    r += options(T.must(pattern[...-1]), target) unless pattern[-1] == '#'
    @memo[[pattern, target]] = r
    r
  end

  sig { returns(Integer) }
  def part1
    @problems.sum do |pattern, target|
      options(pattern, target)
    end
  end

  sig { returns(Integer) }
  def part2
    @problems.sum do |pattern, target|
      options(([pattern] * 5).join('?'), target * 5)
    end
  end
end
