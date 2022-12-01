# frozen_string_literal: true

require 'set'

class Taxicab
  def initialize(input)
    @pos = [0, 0]
    @dirs = [ # Successive direction if you turn right each time
      [0, 1], # North
      [1, 0], # East
      [0, -1], # South
      [-1, 0], # West
    ]
    @curdir = 0 # We're facing north
    @moves = input.split(',').map(&:strip)
  end

  def apply_move!(move)
    @curdir = (@curdir + (if move[0] == 'R'
                            1
                          else
                            (move[0] == 'L' ? -1 : 0)
                          end)) % @dirs.size
    size = move[1..].to_i
    @pos = [@pos[0] + (size * @dirs[@curdir][0]), @pos[1] + (size * @dirs[@curdir][1])]
  end

  def distance
    @pos.sum(&:abs)
  end

  def part1
    @moves.each { |m| apply_move!(m) }
    distance
  end

  def part2
    visited = Set.new
    visited << @pos
    @moves.each do |m|
      dir = m[0]
      apply_move!("#{dir}1")
      size = m[1..].to_i
      (size - 1).times do
        apply_move!('S1') # S for straight, ignored by apply_move!
        return distance if visited.include?(@pos)

        visited << @pos
      end
    end
  end
end
