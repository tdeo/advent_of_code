# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class LanParty
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @connects = T.let(
      Hash.new { |h, k| h[k] = Set.new },
      T::Hash[String, T::Set[String]],
    )
    @input.each_line(chomp: true) do |line|
      a, b = line.split('-')
      T.must(@connects[T.must(a)]) << T.must(b)
      T.must(@connects[T.must(b)]) << T.must(a)
    end
  end

  sig { params(start: T::Array[String]).returns(T::Array[String]) }
  def largest_set_including(start)
    options = T.let(Set.new(@connects.keys), T::Set[String])

    start.each do |elem|
      options &= T.must(@connects[elem])
    end
    options.filter! { _1 > start.last } if start.last
    return start if options.empty?

    T.must(options.map { largest_set_including([*start, _1]) }.max_by(&:size))
  end

  sig { returns(Integer) }
  def part1
    sets = T.let(Set.new, T::Set[[String, String, String]])

    @connects.each do |a, connected|
      connected.each do |b|
        next unless b > a

        connected.each do |c|
          next unless c > b

          sets << [a, b, c] if @connects[b]&.include?(c)
        end
      end
    end

    sets.count { |a, b, c| a.start_with?('t') || b.start_with?('t') || c.start_with?('t') }
  end

  sig { returns(String) }
  def part2
    largest_set_including([]).sort.join(',')
  end
end
