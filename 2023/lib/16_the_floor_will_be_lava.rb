# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class TheFloorWillBeLava
  extend T::Sig

  class Dir < T::Enum
    enums do
      Up = new
      Down = new
      Left = new
      Right = new
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @map = T.let(@input.lines(chomp: true), T::Array[String])
  end

  sig { params(entry: [Integer, Integer, Dir]).returns(Integer) }
  def energized(entry)
    beams = T.let([entry], T::Array[[Integer, Integer, Dir]])
    viewed = T.let(Set.new, T::Set[[Integer, Integer, Dir]])
    until beams.empty?
      beam = T.must(beams.pop)
      i, j, dir = beam
      next if viewed.include?(beam)

      viewed << beam

      succs = T.let([], T::Array[[Integer, Integer, Dir]])
      case T.must(@map[i])[j]
      when '/'
        succs << case dir
                 when Dir::Up then [i, j + 1, Dir::Right]
                 when Dir::Right then [i - 1, j, Dir::Up]
                 when Dir::Down then [i, j - 1, Dir::Left]
                 when Dir::Left then [i + 1, j, Dir::Down]
                 end
      when '\\'
        succs << case dir
                 when Dir::Up then [i, j - 1, Dir::Left]
                 when Dir::Left then [i - 1, j, Dir::Up]
                 when Dir::Down then [i, j + 1, Dir::Right]
                 when Dir::Right then [i + 1, j, Dir::Down]
                 end
      when '|'
        succs << [i - 1, j, Dir::Up] unless dir == Dir::Down
        succs << [i + 1, j, Dir::Down] unless dir == Dir::Up
      when '-'
        succs << [i, j - 1, Dir::Left] unless dir == Dir::Right
        succs << [i, j + 1, Dir::Right] unless dir == Dir::Left
      when '.'
        succs << case dir
                 when Dir::Right then [i, j + 1, Dir::Right]
                 when Dir::Up then [i - 1, j, Dir::Up]
                 when Dir::Left then [i, j - 1, Dir::Left]
                 when Dir::Down then [i + 1, j, Dir::Down]
                 end
      end

      succs.each do |succ|
        i, j, _dir = succ
        next unless i >= 0 && i < @map.size && j >= 0 && j < T.must(@map.first).size

        beams << succ
      end
    end
    viewed.map { _1[0..1] }.uniq.size
  end

  sig { returns(Integer) }
  def part1
    energized([0, 0, Dir::Right])
  end

  sig { returns(Integer) }
  def part2
    best = 0
    (0...@map.size).each do |i|
      best = [
        best,
        energized([i, 0, Dir::Right]),
        energized([i, T.must(@map.first).size - 1, Dir::Left]),
      ].max
    end
    (0...T.must(@map.first).size).each do |j|
      best = [
        best,
        energized([0, j, Dir::Down]),
        energized([@map.size - 1, j, Dir::Up]),
      ].max
    end
    best
  end
end
