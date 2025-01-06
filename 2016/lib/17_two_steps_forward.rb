# frozen_string_literal: true

require 'digest'

class TwoStepsForward
  OPEN = Set.new(%w[b c d e f]).freeze

  def initialize(input)
    @queue = []
    @passcode = input.strip
    # column, row, moves
    @queue << [0, 0, '']
  end

  def hash(moves)
    Digest::MD5.hexdigest(@passcode + moves)
  end

  def options(col, row, moves)
    h = hash(moves)
    yield [col, row - 1, "#{moves}U"] if OPEN.include?(h[0]) && row > 0
    yield [col, row + 1, "#{moves}D"] if OPEN.include?(h[1]) && row < 3
    yield [col - 1, row, "#{moves}L"] if OPEN.include?(h[2]) && col > 0
    yield [col + 1, row, "#{moves}R"] if OPEN.include?(h[3]) && col < 3
  end

  def shortest_path
    until @queue.empty?
      col, row, moves = @queue.shift
      options(col, row, moves) do |o|
        return o[2] if o[0..1] == [3, 3]

        @queue << o
      end
    end
  end

  def longest_path
    longest = nil
    until @queue.empty?
      col, row, moves = @queue.shift
      options(col, row, moves) do |o|
        if o[0..1] == [3, 3]
          longest = moves.size + 1
          next
        end
        @queue << o
      end
    end
    longest
  end

  def part1
    shortest_path
  end

  def part2
    longest_path
  end
end
