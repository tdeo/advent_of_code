# frozen_string_literal: true

class SingleNight
  def initialize(input)
    @distances = Hash.new { |h, k| h[k] = {} }
    input.strip.each_line do |l|
      l =~ /^(\w+) to (\w+) = (\d+)$/
      @distances[$1][$2] = $3.to_i
      @distances[$2][$1] = $3.to_i
    end
  end

  def distance(perm)
    perm.each_cons(2).sum do |a, b|
      @distances[a][b]
    end
  end

  def part1
    @distances.keys.permutation.map do |perm|
      distance(perm)
    end.min
  end

  def part2
    @distances.keys.permutation.map do |perm|
      distance(perm)
    end.max
  end
end
