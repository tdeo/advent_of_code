# frozen_string_literal: true

require 'set'

class Memory
  def initialize(input)
    @banks = input.split(' ').map(&:strip).map(&:to_i)
  end

  def max_case
    @banks.index(@banks.max)
  end

  def deal!
    i = max_case
    k = @banks[i]
    @banks[i] = 0
    k.times do
      i = (i + 1) % @banks.size
      @banks[i] += 1
    end
  end

  def part1
    visited = Set.new
    moves = 0
    until visited.include?(@banks)
      visited << @banks
      deal!
      moves += 1
    end
    moves
  end

  def part2
    visited = {}
    moves = 0
    until visited.key?(@banks)
      visited[@banks] = moves
      deal!
      moves += 1
    end
    moves - visited[@banks]
  end
end
