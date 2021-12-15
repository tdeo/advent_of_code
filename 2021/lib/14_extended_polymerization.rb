# frozen_string_literal: true

class ExtendedPolymerization
  def initialize(input)
    @input = input
    lines = input.split("\n")
    @elem = lines[0].chars
    @inserts = Hash.new { |hash, key| hash[key] = {} }
    lines[2..].each do |line|
      @inserts[line[0]][line[1]] = line[6]
    end

    @pair_occurences = Hash.new(0)
    @elem.each_cons(2) do |a, b|
      @pair_occurences[[a, b]] += 1
    end
  end

  def succ!
    succ = []
    succ << @elem[0]
    @elem.each_cons(2) do |a, b|
      succ << @inserts[a][b] << b
    end
    @elem = succ
  end

  def occurences
    res = Hash.new(0)
    @pair_occurences.each do |(_a, b), c|
      res[b] += c
    end
    res[@elem[0]] += 1
    res
  end

  def succ_occurences!
    succ = Hash.new(0)

    @pair_occurences.each do |(a, b), c|
      middle = @inserts[a][b]

      succ[[a, middle]] += c
      succ[[middle, b]] += c
    end
    @pair_occurences = succ
  end

  def part1(times = 10)
    times.times { succ_occurences! }
    occurences.values.max - occurences.values.min
  end

  def part2
    part1(40)
  end
end
