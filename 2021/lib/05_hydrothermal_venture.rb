# frozen_string_literal: true

class HydrothermalVenture
  def initialize(input)
    @input = input
    @lines = @input.lines.map do |line|
      start, finish = line.split(' -> ')
      {
        start: start.split(',').map(&:to_i),
        finish: finish.split(',').map(&:to_i),
      }
    end
  end

  def sign(int)
    if int > 0
      1
    elsif int == 0
      0
    else
      -1
    end
  end

  def mark(line)
    @grid ||= Hash.new { |h, k| h[k] = Hash.new(0) }

    di = sign(line[:finish][0] - line[:start][0])
    dj = sign(line[:finish][1] - line[:start][1])

    (0..[line[:finish][0] - line[:start][0], line[:finish][1] - line[:start][1]].map(&:abs).max).each do |k|
      @grid[line[:start][0] + (di * k)][line[:start][1] + (dj * k)] += 1
    end
  end

  def score
    count = 0

    @grid.each_value do |row|
      row.each_value do |val|
        count += 1 if val > 1
      end
    end

    count
  end

  def part1
    @lines.each do |line|
      if line[:start][0] == line[:finish][0]
        mark(line)
      elsif line[:start][1] == line[:finish][1]
        mark(line)
      end
    end
    score
  end

  def part2
    @lines.each do |line|
      mark(line)
    end
    score
  end
end
