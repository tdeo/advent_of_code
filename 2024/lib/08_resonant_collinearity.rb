# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class ResonantCollinearity
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @grid = T.let(@input.lines(chomp: true), T::Array[String])
    @beacons = T.let(Hash.new { |h, k| h[k] = [] }, T::Hash[String, T::Array[[Integer, Integer]]])

    @grid.each_with_index do |line, i|
      line.each_char.with_index do |c, j|
        T.must(@beacons[c]) << [i, j] if c != '.'
      end
    end

    @size = T.let([@grid.size, T.must(@grid.first).size].max, Integer)
  end

  sig { params(i: Integer, j: Integer).returns(T::Boolean) }
  def in_grid?(i, j)
    i >= 0 && i < @grid.size && j >= 0 && j < T.must(@grid[0]).size
  end

  sig { returns(Integer) }
  def part1
    antinodes = T.let(Set.new, T::Set[[Integer, Integer]])
    @beacons.each_value do |beacons|
      beacons.permutation(2).each do |a, b|
        next unless a && b

        antinode = [b[0] + b[0] - a[0], b[1] + b[1] - a[1]]
        antinodes << antinode if in_grid?(*antinode)
      end
    end
    antinodes.size
  end

  sig { returns(Integer) }
  def part2
    antinodes = T.let(Set.new, T::Set[[Integer, Integer]])
    @beacons.each_value do |beacons|
      beacons.permutation(2).each do |a, b|
        next unless a && b

        dir = [b[0] - a[0], b[1] - a[1]]
        c = dir[0].gcd(dir[1])
        dir[0] /= c
        dir[1] /= c

        (0...).each do |k|
          antinode = [b[0] + (k * dir[0]), b[1] + (k * dir[1])]
          break unless in_grid?(*antinode)

          antinodes << antinode
        end
      end
    end
    antinodes.size
  end
end
