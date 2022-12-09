# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'set'

class RopeBridge
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @dirs = T.let(input.split("\n").flat_map do |line|
      a, b = line.split
      Array.new(b.to_i) { T.must(a) }
    end, T::Array[String],)
    @tail_visited = T.let(Set.new, T::Set[[Integer, Integer]])
    @snake = T.let(
      [],
      T::Array[[Integer, Integer]],
    )
  end

  sig { params(di: Integer, dj: Integer).void }
  def move_head(di, dj)
    T.must(@snake[0])[0] += di
    T.must(@snake[0])[1] += dj
  end

  sig { params(tail: [Integer, Integer], head: [Integer, Integer]).void }
  def follow_tail(tail, head)
    return if (tail[0] - head[0]).abs <= 1 && (tail[1] - head[1]).abs <= 1

    tail[0] = (((2 * head[0]) + tail[0]) / 3.0).round
    tail[1] = (((2 * head[1]) + tail[1]) / 3.0).round
  end

  sig { params(tail: [Integer, Integer]).void }
  def store_tail_position(tail)
    @tail_visited << [*tail]
  end

  sig { params(dir: String).void }
  def move(dir)
    case dir
    when 'U' then move_head(-1, 0)
    when 'D' then move_head(1, 0)
    when 'L' then move_head(0, -1)
    when 'R' then move_head(0, 1)
    else raise "Unrecognized dir #{dir}"
    end
  end

  sig { void }
  def debug
    mini, maxi = @snake.map(&:first).minmax
    minj, maxj = @snake.map(&:last).minmax

    grid = (mini..maxi).map do
      (minj..maxj).map { '.' }.join
    end
    @snake.each_with_index do |pos, idx|
      i = pos[0] - T.must(mini)
      j = pos[1] - T.must(minj)
      T.must(grid[i])[j] = idx.to_s if T.must(grid[i])[j] == '.'
    end
    puts grid.join("\n")
    puts ''
  end

  sig { params(snake_size: Integer).returns(Integer) }
  def part1(snake_size = 2)
    @snake = Array.new(snake_size) { [0, 0] }
    @dirs.each do |dir|
      move(dir)
      @snake.each_cons(2) do |head, tail|
        follow_tail(tail, head)
      end
      store_tail_position(@snake[-1])
    end
    @tail_visited.size
  end

  sig { returns(Integer) }
  def part2
    part1(10)
  end
end
