# frozen_string_literal: true

class BinaryDiagnostic
  def initialize(input)
    @input = input
    @lines = @input.split("\n")
  end

  def gamma_rate
    digit = ''

    (0...@lines.first.size).each do |i|
      digit += @lines.map { _1[i] }.tally.max_by(&:last).first
    end

    digit.to_i(2)
  end

  def epsilon_rate
    digit = ''

    (0...@lines.first.size).each do |i|
      digit += @lines.map { _1[i] }.tally.min_by(&:last).first
    end

    digit.to_i(2)
  end

  def part1
    gamma_rate * epsilon_rate
  end

  def oxygen_generator_rating
    numbers = @lines
    (0...numbers.first.size).each do |i|
      digits = numbers.map { _1[i] }.tally
      digit = digits.max_by { [_1.last, _1.first] }.first
      numbers = numbers.select { _1[i] == digit }
      return numbers.first.to_i(2) if numbers.size == 1
    end
  end

  def co2_scrubber_rating
    numbers = @lines
    (0...numbers.first.size).each do |i|
      digits = numbers.map { _1[i] }.tally
      digit = digits.min_by { [_1.last, _1.first] }.first
      numbers = numbers.select { _1[i] == digit }
      return numbers.first.to_i(2) if numbers.size == 1
    end
  end

  def part2
    oxygen_generator_rating * co2_scrubber_rating
  end
end
