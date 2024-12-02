# frozen_string_literal: true

class Matchsticks
  def initialize(input)
    @strings = input.split("\n").map(&:strip)
  end

  def part1
    @strings.sum { |str| str.size - eval(str).size } # rubocop:disable Security/Eval
  end

  def part2
    @strings.sum { |str| str.inspect.size - str.size }
  end
end
