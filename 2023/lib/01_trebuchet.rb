# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Trebuchet
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @lines = T.let(input.split("\n"), T::Array[String])
  end

  sig { returns(Integer) }
  def part1
    @lines.sum do |line|
      digits = line.gsub(/[^\d]/, '')
      (10 * digits[0].to_i) + digits[-1].to_i
    end
  end

  sig { returns(Integer) }
  def part2
    @lines.sum do |line|
      matches = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
      (10 * to_i(matches.first)) + to_i(matches.last)
    end
  end

  private

  sig { params(str: T.nilable(String)).returns(Integer) }
  def to_i(str)
    case str
    when 'one' then 1
    when 'two' then 2
    when 'three' then 3
    when 'four' then 4
    when 'five' then 5
    when 'six' then 6
    when 'seven' then 7
    when 'eight' then 8
    when 'nine' then 9
    else str.to_i
    end
  end
end
