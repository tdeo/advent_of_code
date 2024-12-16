# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class GardenGroups
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @map = T.let(@input.each_line(chomp: true).map(&:chars), T::Array[T::Array[String]])
  end

  sig { params(visited: T::Set[[Integer, Integer]]).returns(T.nilable([Integer, Integer])) }
  def find_next_region(visited)
    @map.each_with_index do |row, i|
      row.each_with_index do |_c, j|
        return [i, j] unless visited.include?([i, j])
      end
    end
    nil
  end

  sig { params(i: Integer, j: Integer).returns(T::Array[[Integer, Integer]]) }
  def neighbours(i, j)
    [
      [i - 1, j],
      [i + 1, j],
      [i, j - 1],
      [i, j + 1],
    ].filter { |x, y| x >= 0 && y >= 0 && x < @map.size && y < T.must(@map[x]).size }
  end

  sig { params(start: [Integer, Integer]).returns([Integer, T::Set[[Integer, Integer]]]) }
  def region_value(start)
    visited = Set.new
    perimeter = 0
    q = [start]
    loop do
      h = q.shift
      break if h.nil?
      next if visited.include?(h)

      visited << h
      perimeter += 4
      i, j = h
      neighbours(i, j).each do |ii, jj|
        if T.must(@map[ii])[jj] == T.must(@map[i])[j]
          q << [ii, jj]
          perimeter -= 1
        end
      end
    end
    [perimeter * visited.size, visited]
  end

  extend T::Sig
  sig { returns(Integer) }
  def part1
    res = 0
    visited = T.let(Set.new, T::Set[[Integer, Integer]])
    while (start = find_next_region(visited))
      val, spots = region_value(start)
      res += val
      visited |= spots
    end
    res
  end

  sig { params(region: T::Array[[Integer, Integer]]).returns(Integer) }
  def vertical_sides(region)
    previous = T.let([], T::Array[[T.nilable(Integer), T::Boolean]])
    grouped = region.group_by(&:first)
    c = 0
    grouped.keys.sort.each do |i|
      tiles = T.must(grouped[i]).map(&:last).sort
      current = T.let([[tiles[0], true]], T::Array[[T.nilable(Integer), T::Boolean]])
      tiles.each_cons(2) do |a, b|
        next if b == T.must(a) + 1

        current << [(T.must(a) + 1), false] << [b, true]
      end
      current << [T.must(tiles.last) + 1, false]
      c += (current - previous).size
      previous = current
    end
    c
  end

  sig { params(region: T::Set[[Integer, Integer]]).returns(Integer) }
  def sides(region)
    reversed = region.map { |i, j| [j, i] }
    vertical_sides(region.to_a) + vertical_sides(reversed)
  end

  extend T::Sig
  sig { returns(Integer) }
  def part2
    res = 0
    visited = T.let(Set.new, T::Set[[Integer, Integer]])
    while (start = find_next_region(visited))
      _val, spots = region_value(start)
      sides = sides(spots)
      res += sides * spots.size
      visited |= spots
    end
    res
  end
end
