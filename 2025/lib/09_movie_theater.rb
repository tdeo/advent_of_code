# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MovieTheater
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @corners = T.let(input.lines(chomp: true).map do |line|
      x, y = line.split(',').map(&:to_i)
      [x.to_i, y.to_i]
    end, T::Array[[Integer, Integer]],)
  end

  sig { returns(Integer) }
  def part1
    @corners.combination(2).map do |c1, c2|
      area(T.must(c1), T.must(c2))
    end.max.to_i
  end

  sig { params(c1: [Integer, Integer], c2: [Integer, Integer]).returns(Integer) }
  def area(c1, c2)
    ((c1[0] - c2[0]).abs + 1) * ((c1[1] - c2[1]).abs + 1)
  end

  sig { params(map: T::Array[String], i_indexes: T::Hash[Integer, Integer], j_indexes: T::Hash[Integer, Integer]).void }
  def fill_border(map, i_indexes, j_indexes)
    @corners << T.must(@corners.first)
    @corners.each_cons(2) do |c1, c2|
      c1 = T.must(c1)
      c2 = T.must(c2)
      c1 = [i_indexes[c1[0]], j_indexes[c1[1]]]
      c2 = [i_indexes[c2[0]], j_indexes[c2[1]]]
      imin, imax = [c1[0], c2[0]].minmax
      jmin, jmax = [c1[1], c2[1]].minmax
      (imin..imax).each do |i|
        (jmin..jmax).each do |j|
          T.must(map[i])[j] = '#'
        end
      end
    end
    @corners.pop
  end

  sig { params(map: T::Array[String]).void }
  def fill_outside(map)
    queue = T.let([[0, 0]], T::Array[[Integer, Integer]])
    while (a = queue.pop)
      i, j = a
      [[i - 1, j], [i + 1, j], [i, j - 1], [i, j + 1]].each do |ii, jj|
        next if ii < 0 || ii >= map.size || jj < 0 || jj >= T.must(map[0]).size
        next if T.must(map[ii])[jj] != '.'

        T.must(map[ii])[jj] = 'X'
        queue << [ii, jj]
      end
    end
  end

  sig { returns(Integer) }
  def part2
    i_indexes = @corners.map(&:first).uniq.sort
    i_indexes = [T.must(i_indexes.first) - 1, *i_indexes, T.must(i_indexes.last) + 1].each_with_index.to_h

    j_indexes = @corners.map(&:last).uniq.sort
    j_indexes = [T.must(j_indexes.first) - 1, *j_indexes, T.must(j_indexes.last) + 1].each_with_index.to_h

    map = i_indexes.map { '.' * j_indexes.size }
    fill_border(map, i_indexes, j_indexes)
    fill_outside(map)

    best = 0
    @corners.combination(2).each do |c1, c2|
      c1 = T.must(c1)
      c2 = T.must(c2)

      i1, i2 = [i_indexes[c1[0]], i_indexes[c2[0]]].minmax
      j1, j2 = [j_indexes[c1[1]], j_indexes[c2[1]]].minmax
      valid = T.let(true, T::Boolean)
      (i1..i2).each do |i|
        break unless valid

        (j1..j2).each do |j|
          break valid = false if T.must(map[i])[j] == 'X'
        end
      end
      next unless valid

      best = [best, area(c1, c2)].max
    end
    best
  end
end
