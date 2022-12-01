# frozen_string_literal: true

class HighEntropyPassphrases
  def initialize(input)
    @phrases = input.split("\n")
  end

  def words(phrase)
    phrase.split.map(&:strip).reject(&:empty?)
  end

  def valid1(phrase)
    w = words(phrase)
    w.size == w.uniq.size
  end

  def part1
    @phrases.count { |p| valid1(p) }
  end

  def valid2(phrase)
    w = words(phrase).map(&:chars).map(&:sort)
    w.size == w.uniq.size
  end

  def part2
    @phrases.count { |p| valid2(p) }
  end
end
