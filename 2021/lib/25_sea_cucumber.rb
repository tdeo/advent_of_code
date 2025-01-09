# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class SeaCucumber
  extend T::Sig

  Coords = T.type_alias { [Integer, Integer] }

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @map = T.let(@input.lines(chomp: true), T::Array[String])
  end

  sig { returns(T::Array[Coords]) }
  def move!
    right = T.let([], T::Array[Coords])
    @map.each_with_index do |row, i|
      row.each_char.with_index do |char, j|
        next unless char == '>'

        neighbour = row[(j + 1) % row.size]
        next unless neighbour == '.'

        right << [i, j]
      end
    end
    right.each do |i, j|
      T.must(@map[i])[j] = '.'
      T.must(@map[i])[(j + 1) % T.must(@map[0]).size] = '>'
    end

    down = T.let([], T::Array[Coords])
    @map.each_with_index do |row, i|
      row.each_char.with_index do |char, j|
        next unless char == 'v'

        neighbour = T.must(@map[(i + 1) % @map.size])[j]
        next unless neighbour == '.'

        down << [i, j]
      end
    end
    down.each do |i, j|
      T.must(@map[i])[j] = '.'
      T.must(@map[(i + 1) % @map.size])[j] = 'v'
    end

    right | down
  end

  sig { returns(Integer) }
  def part1
    (1..).find do
      move!.empty?
    end || 0
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
