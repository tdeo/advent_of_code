# frozen_string_literal: true

class TheStarsAlign
  def initialize(input)
    @input = input
    @stars = []
    @input.each_line do |l|
      m = l.match(/position=<(\s?-?\d+), (\s?-?\d+)> velocity=<(\s?-?\d+), (\s?-?\d+)>/)
      @stars << m[1..4].map(&:to_i)
    end
  end

  def area
    w = @stars.map { |e| e[0] }.minmax
    h = @stars.map { |e| e[1] }.minmax
    (w[1] - w[0]) * (h[1] - h[0])
  end

  def move!
    @stars.each do |s|
      s[0] += s[2]
      s[1] += s[3]
    end
  end

  def reverse_move!
    @stars.each do |s|
      s[0] -= s[2]
      s[1] -= s[3]
    end
  end

  def print!
    w = @stars.map { |e| e[0] }.minmax
    h = @stars.map { |e| e[1] }.minmax

    view = (h[0]..h[1]).map do
      '.' * (w[1] - w[0] + 1)
    end

    @stars.each do |s|
      view[s[1] - h[0]][s[0] - w[0]] = '#'
    end

    puts view.join("\n")
  end

  def part1
    a = Float::INFINITY
    loop do
      move!
      b = area
      break if b > a

      a = b
    end
    reverse_move!
    print!
  end

  def part2
    a = Float::INFINITY
    time = 0
    loop do
      move!
      time += 1
      b = area
      break if b > a

      a = b
    end
    time - 1
  end
end
