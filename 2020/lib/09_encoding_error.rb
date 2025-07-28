# frozen_string_literal: true

class EncodingError
  def initialize(input)
    @input = input
    @numbers = @input.each_line.map(&:to_i)
  end

  def setup
    @visible = Hash.new(0)
    (0...@n).each do |i|
      @visible[@numbers[i]] += 1
    end
  end

  def valid?
    target = @numbers[@index]
    ((@index - @n)...@index).each do |i|
      return true if @visible.key?(target - @numbers[i])
    end
    false
  end

  def succ!
    prev = @numbers[@index - @n]
    if @visible[prev] == 1
      @visible.delete(prev)
    else
      @visible[prev] -= 1
    end
    @index += 1
    @visible[@numbers[@index]] += 1
  end

  def part1(preamble_size = 25)
    @n = preamble_size
    setup
    @index = preamble_size

    succ! while valid?

    @numbers[@index]
  end

  def part2(preamble_size = 25)
    target = part1(preamble_size)

    cumulated = 0
    viewed = { 0 => 0 }
    @numbers.each_with_index do |number, i|
      cumulated += number
      viewed[cumulated] = i + 1

      next unless viewed.key?(cumulated - target)

      start = viewed[cumulated - target]

      return @numbers[start..i].minmax.sum
    end
  end
end
