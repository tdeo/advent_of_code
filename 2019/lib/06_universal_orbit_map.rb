# frozen_string_literal: true

class UniversalOrbitMap
  def initialize(input)
    @input = input
    @orbits = Hash.new { |h, k| h[k] = [] }
    @rorbits = {}
    input.each_line do |l|
      a, b = l.strip.split(')')
      @orbits[a] << b
      @rorbits[b] = a
    end
  end

  def children(node)
    r = 0
    @orbits[node].each do |c|
      r += children(c) + 1
    end
    r
  end

  def total(node)
    r = 0
    @orbits[node].map do |c|
      r += total(c) + children(c) + 1
    end
    r
  end

  def part1
    total('COM')
  end

  def parents(node)
    res = [node]
    res << @rorbits[res[-1]] while @rorbits[res[-1]]
    res
  end

  def part2
    a = parents('YOU')
    b = parents('SAN')
    c = a & b
    ((a - c).size + (b - c).size) - 2
  end
end
