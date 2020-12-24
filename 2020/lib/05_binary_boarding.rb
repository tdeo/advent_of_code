class BinaryBoarding
  def initialize(input)
    @input = input
    @seats = @input.each_line.map(&:chomp)
  end

  def row(seat)
    row = 0
    seat.chars.first(7).each_with_index do |c, i|
      row += 2**(6 - i) if c == 'B'
    end
    row
  end

  def col(seat)
    col = 0
    seat.chars.last(3).each_with_index do |c, i|
      col += 2**(2 - i) if c == 'R'
    end
    col
  end

  def seat_id(seat)
    row(seat) * 8 + col(seat)
  end

  def part1
    @seats.map { seat_id _1 }.max
  end

  def part2
    taken = @seats.map { [seat_id(_1), true] }.to_h
    (taken.keys.min..taken.keys.max).each do |i|
      return i unless taken.include? i
    end
  end
end
