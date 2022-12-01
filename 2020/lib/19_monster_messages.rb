# frozen_string_literal: true

class MonsterMessages
  def initialize(input)
    @input = input

    rules, lines = @input.split("\n\n")
    @lines = lines.split("\n")
    @rules = rules.split("\n").to_h do |r|
      a, b = r.split(': ')
      [a.to_i, b.strip]
    end
  end

  def matches?(rules, string)
    return string.empty? if rules.empty?

    first = @rules[rules[0]]

    if first =~ /"(.*)"/
      return matches?(rules[1..], string[$1.size..]) if string.start_with?($1)

      return false
    end

    options = first.split('|')

    options.any? do |option|
      subrules = option.split.map(&:to_i)

      matches?(subrules + rules[1..], string)
    end
  end

  def part1
    @lines.count { |line| matches?([0], line) }
  end

  def part2
    @rules[8] = '42 | 42 8'
    @rules[11] = '42 31 | 42 11 31'

    @lines.count { |line| matches?([0], line) }
  end
end
