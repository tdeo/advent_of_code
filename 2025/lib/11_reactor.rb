# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Reactor
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @neighbors = T.let({}, T::Hash[String, T::Array[String]])
    @input.each_line(chomp: true).each do |line|
      from, *to = line.split
      from = T.must(from)[...-1]

      @neighbors[T.must(from)] = to
    end
    @paths_to_out = T.let({}, T::Hash[String, Integer])
  end

  sig { params(from: String, to: String, cache: T::Hash[String, Integer]).returns(Integer) }
  def paths_count(from, to, cache: {})
    return 1 if from == to

    cache[from] ||= @neighbors.fetch(from, []).sum do |neighbor|
      paths_count(neighbor, to, cache: cache)
    end
  end

  sig { returns(Integer) }
  def part1
    paths_count('you', 'out')
  end

  sig { returns(Integer) }
  def part2
    (paths_count('svr', 'fft') * paths_count('fft', 'dac') * paths_count('dac', 'out')) +
      (paths_count('svr', 'dac') * paths_count('dac', 'fft') * paths_count('fft', 'out'))
  end
end
