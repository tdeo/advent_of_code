# frozen_string_literal: true

class ExperimentalEmergencyTeleportation
  def initialize(input)
    @input = input
    @bots = []
    @input.split("\n").each do |l|
      @bots << l.match(/pos=<(-?\d+),(-?\d+),(-?\d+)>, r=(\d+)$/)[1..4].map(&:to_i)
    end
  end

  def dist(b1, b2)
    b1.zip(b2)[0..2].sum { |a, b| (a - b).abs }
  end

  def part1
    best_dist = 0
    best_bot = nil
    @bots.each do |bot|
      if bot[-1] > best_dist
        best_dist = bot[-1]
        best_bot = bot
      end
    end

    c = 0
    @bots.each do |bot|
      c += 1 if dist(best_bot, bot) <= best_dist
    end
    c
  end

  def connected?(i1, i2)
    return true if i1 == i2

    @connected ||= Hash.new { |h, k| h[k] = {} }
    @connected[i1][i2] ||= (dist(@bots[i1], @bots[i2]) <= @bots[i1][-1] + @bots[i2][-1])
  end

  def strongly_connected(idxs)
    return [[]] if idxs.empty?

    a = idxs.first
    c = []
    nc = []
    idxs[1..].each do |i|
      connected?(a, i) ? (c << i) : (nc << i)
    end

    nc = strongly_connected(nc)
    c = strongly_connected(c)

    c.each { |e| e << a }

    res = []
    res += c if c.first.size >= nc.first.size
    res += nc if nc.first.size >= c.first.size

    res
  end

  def part2
    (0...@bots.size).each do |i|
      (0...@bots.size).each do |j|
        connected?(i, j)
      end
    end

    comp = strongly_connected (0...@bots.size).to_a
    raise if comp.size != 1 # Edge case not handled

    r = 0
    comp[0].each do |i|
      r = [
        r,
        @bots[i][0..2].sum(&:abs) - @bots[i][-1],
      ].max
    end
    r
  end
end
