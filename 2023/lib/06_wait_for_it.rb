# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class WaitForIt
  extend T::Sig

  class Race < T::Struct
    extend T::Sig

    prop :duration, Integer
    prop :record, Integer

    sig { returns(Integer) }
    def winning_ways
      first = (0...duration).find { _1 * (duration - _1) > record }
      last = duration.downto(0).find { _1 * (duration - _1) > record }
      return 0 if first.nil? || last.nil?

      (last - first + 1)
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @durations = T.let(T.must(T.must(@input.split("\n")[0]).split[1..]).map(&:to_i), T::Array[Integer])
    @records = T.let(T.must(T.must(@input.split("\n")[1]).split[1..]).map(&:to_i), T::Array[Integer])
    @races = T.let(@durations.zip(@records).map do |dur, rec|
      Race.new(duration: dur, record: T.must(rec))
    end, T::Array[Race],)
  end

  sig { returns(Integer) }
  def part1
    @races.reduce(1) { |res, race| res * race.winning_ways }
  end

  sig { returns(Integer) }
  def part2
    Race.new(duration: @durations.join.to_i, record: @records.join.to_i).winning_ways
  end
end
