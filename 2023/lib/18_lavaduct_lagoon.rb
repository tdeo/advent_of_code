# typed: strong
# frozen_string_literal: true

require 'byebug'
require 'sorbet-runtime'
require_relative '../../lib/map'

class LavaductLagoonx < Map
  extend T::Sig

  Elem = type_member { { fixed: String } }

  sig { params(input: String).void }
  def initialize(input)
    @input = input

    used = T.let([[0, 0]], T::Array[Coords])
    @input.each_line(chomp: true) do |line|
      dir, count, = line.split
      count.to_i.times do
        i, j = T.must(used.last)
        used << case dir
                when 'U' then [i - 1, j]
                when 'D' then [i + 1, j]
                when 'L' then [i, j - 1]
                when 'R' then [i, j + 1]
                else raise
                end
      end
    end
    mini, maxi = used.map(&:first).minmax
    minj, maxj = used.map(&:last).minmax
    map = T.let(
      Array.new(T.must(maxi) - T.must(mini) + 1) { '.' * (T.must(maxj) - T.must(minj) + 1) },
      T::Array[String],
    )
    used.each { T.must(map[_1.first - T.must(mini)])[_1.last - T.must(minj)] = '#' }
    super(map.join("\n")) { _1 }
  end

  sig { returns(Integer) }
  def part1
    p [@width, @height]
    puts @grid.map(&:join)
    q = T.let([], T::Array[Cell[String]])
    viewed = T.let(Set.new, T::Set[Coords])

    (0...@width).each do |j|
      q << T.must(at(0, j))
      q << T.must(at(@height - 1, j))
    end
    (0...@height).each do |i|
      q << T.must(at(i, 0))
      q << T.must(at(i, @width - 1))
    end
    q.select! { _1.value == '.' }

    until q.empty?
      h = T.must(q.shift)
      next if viewed.include?(h.coords)

      viewed << h.coords
      h.neighbours.each { q << _1 if _1.value == '.' }
    end

    (@width * @height) - viewed.size
  end

  sig { returns(Integer) }
  def part2
    0
  end
end

class LavaductLagoon
  extend T::Sig

  class Dir < T::Enum
    enums do
      Up = new('U')
      Down = new('D')
      Left = new('L')
      Right = new('R')
    end
  end

  class Move < T::Struct
    extend T::Sig

    prop :dist, Integer
    prop :dir, Dir

    sig { returns(String) }
    def inspect
      "#{dist} #{T.must(dir.to_s.split('::').last)[...-1]}"
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @moves = T.let([], T::Array[Move])
    @input.each_line(chomp: true) do |line|
      dir, count, = line.split
      @moves << Move.new(dir: Dir.deserialize(dir), dist: count.to_i)
    end
  end

  sig { params(first_dir: Dir, second_dir: Dir).returns(T::Boolean) }
  def right_turn?(first_dir, second_dir)
    return second_dir == Dir::Down if first_dir == Dir::Right
    return second_dir == Dir::Up if first_dir == Dir::Left
    return second_dir == Dir::Right if first_dir == Dir::Up
    return second_dir == Dir::Left if first_dir == Dir::Down

    raise
  end

  sig { params(first_dir: Dir, second_dir: Dir).returns(T::Boolean) }
  def opposite?(first_dir, second_dir)
    return second_dir == Dir::Left if first_dir == Dir::Right
    return second_dir == Dir::Right if first_dir == Dir::Left
    return second_dir == Dir::Down if first_dir == Dir::Up
    return second_dir == Dir::Up if first_dir == Dir::Down

    raise
  end

  sig { returns(Integer) }
  def part1
    delta = 0
    while @moves.size >= 3
      (0...@moves.size - 3).each do |i|
        _ = T.must(@moves[i])
        _ = T.must(@moves[i + 1])
        _ = T.must(@moves[i + 2])
      end

      a, b, c = T.must(@moves[-3..])
      a = T.must(a)
      b = T.must(b)
      c = T.must(c)

      p delta
      p @moves

      if b.dir == c.dir
        puts 'Opt 1'
        b.dist += c.dist
        @moves.pop
      elsif opposite?(b.dir, c.dir)
        puts 'Opt 2'
        c.dist -= b.dist
        b.dist = -c.dist
        @moves.delete_at(c.dist < 0 ? -1 : -2)
      elsif a.dir == b.dir
        puts 'Opt 3'
        a.dist += b.dist
        @moves.delete_at(-2)
      elsif opposite?(a.dir, b.dir)
        puts 'Opt 4'
        b.dist -= a.dist
        a.dist = -b.dist
        @moves.delete_at(a.dist < 0 ? -3 : -2)
      elsif a.dir == c.dir
        puts 'Opt 5'
        sign = right_turn?(a.dir, b.dir) ? 1 : -1
        delta += sign * b.dist * c.dist
        a.dist += c.dist
        @moves.pop
      else
        puts 'Opt 6'
        sign = right_turn?(a.dir, b.dir) ? 1 : -1
        delta += sign * [a.dist, c.dist].min * (b.dist - 1)
        a.dist -= c.dist
        c.dist = -a.dist
        @moves.delete_at(a.dist <= 0 ? -3 : -1)
        @moves.pop if c.dist == 0
      end
    end

    delta.abs
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
