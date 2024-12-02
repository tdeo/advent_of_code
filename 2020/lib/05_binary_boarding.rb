# frozen_string_literal: true

class BinaryBoarding
  def initialize(input)
    @input = input
    @seats = @input.each_line.map(&:chomp)
  end

  def row(seat)
    row = 0
    seat[0...7].chars.each_with_index do |c, i|
      row += 2**(6 - i) if c == 'B'
    end
    row
  end

  def col(seat)
    col = 0
    seat[-3..].chars.each_with_index do |c, i|
      col += 2**(2 - i) if c == 'R'
    end
    col
  end

  def seat_id(seat)
    (row(seat) * 8) + col(seat)
  end

  def part1
    @seats.map { seat_id _1 }.max
  end

  def part2
    taken = @seats.to_h { [seat_id(_1), true] }
    (taken.keys.min..taken.keys.max).each do |i|
      return i unless taken.include? i
    end
  end
end
