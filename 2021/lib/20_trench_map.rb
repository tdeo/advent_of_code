# frozen_string_literal: true

class TrenchMap
  def initialize(input)
    @padding = '.'
    @input = input
    @code, @image = input.split("\n\n")
    @image = @image.split("\n").map(&:chars)

    @mapping = Hash.new do |hash, key|
      hash[key] = @code[key.tr('.#', '01').to_i(2)]
    end
  end

  def at(i, j)
    return @padding if i < 0 || i >= @image.size

    row = @image[i]
    return @padding if j < 0 || j >= row.size

    row[j]
  end

  def code(i, j)
    (i - 1..i + 1).flat_map do |ii|
      (j - 1..j + 1).map { |jj| at(ii, jj) }
    end.join
  end

  def next_value(i, j)
    @mapping[code(i, j)]
  end

  def step!
    @image.each do |row|
      row.unshift(@padding)
      row.push(@padding)
    end

    @image.unshift([@padding] * @image[0].size)
    @image.push([@padding] * @image[0].size)

    @next_image = []
    (0...@image.size).each do |i|
      @next_image << []
      (0...@image[i].size).each do |j|
        @next_image[-1] << next_value(i, j)
      end
    end
    @image = @next_image
    @padding = @mapping[@padding * 9]
  end

  def lit_count
    @image.sum { _1.count('#') }
  end

  def print!
    @image.each { puts _1.join }
  end

  def part1(times = 2)
    times.times { step! }
    lit_count
  end

  def part2
    part1(50)
  end
end
