# typed: strong
# frozen_string_literal: true

require 'byebug'
require 'sorbet-runtime'

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

  sig { returns(Integer) }
  def part1
    x = y = 0
    area = perimeter = 0

    @moves.each do |move|
      case move.dir
      when Dir::Up
        y += move.dist
      when Dir::Down
        y -= move.dist
      when Dir::Left
        x += move.dist
        area -= move.dist * y
      when Dir::Right
        x -= move.dist
        area += move.dist * y
      end

      perimeter += move.dist
    end

    area.abs + (perimeter / 2) + 1
  end

  sig { returns(Integer) }
  def part2
    @moves = @input.each_line(chomp: true).map do |line|
      _dir, _count, color = line.split
      color = color[2...-1]
      dir = case color[-1]
            when '0' then Dir::Right
            when '1' then Dir::Down
            when '2' then Dir::Left
            when '3' then Dir::Up
            else raise "Unknown color: #{color}"
            end
      dist = color[0...-1].to_i(16)
      Move.new(dir: dir, dist: dist)
    end

    part1
  end
end
