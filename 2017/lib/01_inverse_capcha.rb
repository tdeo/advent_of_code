# frozen_string_literal: true

class InverseCapcha
  def initialize(input)
    @input = input.strip
    @chars = @input.chars
    @size = @chars.size
  end

  def [](i)
    @chars[i % @size]
  end

  def part1
    sum = 0
    (0...@size).map do |i|
      sum += self[i].to_i if self[i] == self[i + 1]
    end
    sum
  end

  def part2
    sum = 0
    (0...@size).map do |i|
      sum += self[i].to_i if self[i] == self[i + @size / 2]
    end
    sum
  end
end
