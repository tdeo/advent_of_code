# frozen_string_literal: true

class Spinlock
  def initialize(input)
    @pos = 0
    @steps = input.to_i
    @buffer = [0]
  end

  def move!
    @pos = (@pos + @steps + 1) % @buffer.size
    @buffer.insert(@pos, @buffer.size)
  end

  def part1
    2017.times { move! }
    @buffer[(@pos + 1) % @buffer.size]
  end

  def part2
    pos = 0
    size = 1
    follower = nil
    (1..50_000_000).each do |i|
      new_pos = (pos + @steps) % size
      size += 1
      follower = i if new_pos == 0
      pos = new_pos + 1
    end
    follower
  end
end
