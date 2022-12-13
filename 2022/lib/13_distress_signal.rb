# frozen_string_literal: true

class DistressSignal
  def compare(a, b)
    if a.is_a?(Integer) && b.is_a?(Integer)
      return -1 if a < b
      return 1 if a > b

      return 0
    elsif a.is_a?(Integer)
      return compare([a], b)
    elsif b.is_a?(Integer)
      return compare(a, [b])
    end

    return 0 if a.empty? && b.empty?

    return -1 if a.empty?

    return 1 if b.empty?

    a0 = a.first
    b0 = b.first
    c = compare(a0, b0)
    return c if c != 0

    compare(a[1..], b[1..])
  end

  def initialize(input)
    @input = input
    @packet_pairs = []
    @input.split("\n\n").each do |pair|
      @packet_pairs << pair.split("\n").map { eval _1 } # rubocop:disable Security/Eval
    end
  end

  def part1
    res = 0
    @packet_pairs.each_with_index do |pair, i|
      res += i + 1 if compare(*pair) < 0
    end
    res
  end

  def part2
    packets = @packet_pairs.flatten(1)
    c1 = (1 + packets.count { |a| compare(a, [[2]]) < 0 })
    c2 = (2 + packets.count { |a| compare(a, [[6]]) < 0 })
    c1 * c2
  end
end
