# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class PointofIncidence
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @maps = T.let(
      @input.split("\n\n").map { _1.lines(chomp: true) },
      T::Array[T::Array[String]],
    )
  end

  sig { params(map: T::Array[String], i: Integer).returns(String) }
  def col(map, i)
    map.map { _1[i] }.join
  end

  sig { params(map: T::Array[String], j: Integer).returns(Integer) }
  def errors_for_vertical_line(map, j)
    res = 0
    (0...j).each do |jj|
      other = ((2 * j) - 1) - jj
      next if other >= T.must(map.first).size

      res += (0...map.size).count do |i|
        T.must(map[i])[jj] != T.must(map[i])[other]
      end
    end
    res
  end

  sig { params(map: T::Array[String], i: Integer).returns(Integer) }
  def errors_for_horizontal_line(map, i)
    res = 0
    (0...i).each do |ii|
      other = ((2 * i) - 1) - ii
      next if other >= map.size

      res += (0...T.must(map.first).size).count do |j|
        T.must(map[ii])[j] != T.must(map[other])[j]
      end
    end
    res
  end

  sig { params(map: T::Array[String], target: Integer).returns(T.nilable(Integer)) }
  def vertical_line(map, target: 0)
    (1...T.must(map.first).size).find do |i|
      errors_for_vertical_line(map, i) == target
    end
  end

  sig { params(map: T::Array[String], target: Integer).returns(T.nilable(Integer)) }
  def horizontal_line(map, target: 0)
    (1...map.size).find do |i|
      errors_for_horizontal_line(map, i) == target
    end
  end

  sig { returns(Integer) }
  def part1
    @maps.sum do |map|
      (100 * (horizontal_line(map) || 0)) + (vertical_line(map) || 0)
    end
  end

  sig { returns(Integer) }
  def part2
    @maps.sum do |map|
      (100 * (horizontal_line(map, target: 1) || 0)) + (vertical_line(map, target: 1) || 0)
    end
  end
end
