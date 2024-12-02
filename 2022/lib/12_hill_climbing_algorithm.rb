# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class HillClimbingAlgorithm
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @start = T.let([-1, -1], [Integer, Integer])
    @finish = T.let([-1, -1], [Integer, Integer])
    @grid = T.let([], T::Array[T::Array[Integer]])
    @grid = T.let(@input.split("\n").each_with_index.map do |row, i|
      T.let(row.each_char.map.with_index do |char, j|
        case char
        when 'S'
          @start = [i, j]
          0
        when 'E'
          @finish = [i, j]
          'z'.ord - 'a'.ord
        else
          char.ord - 'a'.ord
        end
      end, T::Array[Integer],)
    end, T::Array[T::Array[Integer]],)
  end

  sig { params(i: Integer, j: Integer).returns(T::Array[[Integer, Integer]]) }
  def neighbours(i, j)
    r = T.let([
      [i - 1, j],
      [i + 1, j],
      [i, j - 1],
      [i, j + 1],
    ], T::Array[[Integer, Integer]],)

    r.reject! do |ii, jj|
      ii < 0 || jj < 0 || ii >= @grid.size || jj >= T.must(@grid[ii]).size
    end

    r
  end

  sig { returns(Integer) }
  def part1
    queue = T.let([@start], T::Array[[Integer, Integer]])
    visited = T.let({ @start => 0 }, T::Hash[[Integer, Integer], Integer])

    until queue.empty?
      pos = T.must(queue.shift)
      dist = T.must(visited[pos])

      return dist if pos == @finish

      neighbours(*pos).each do |n|
        next if visited.key?(n)

        ii, jj = *n
        next if T.must(T.must(@grid[ii])[jj]) > T.must(T.must(@grid[pos[0]])[pos[1]]) + 1

        queue << n
        visited[n] = dist + 1
      end
    end

    raise 'No path found'
  end

  sig { returns(Integer) }
  def part2
    queue = T.let([@finish], T::Array[[Integer, Integer]])
    visited = T.let({ @finish => 0 }, T::Hash[[Integer, Integer], Integer])

    until queue.empty?
      pos = T.must(queue.shift)
      dist = T.must(visited[pos])

      return dist if T.must(@grid[pos[0]])[pos[1]] == 0

      neighbours(*pos).each do |n|
        next if visited.key?(n)

        ii, jj = *n
        next if T.must(T.must(@grid[ii])[jj]) < T.must(T.must(@grid[pos[0]])[pos[1]]) - 1

        queue << n
        visited[n] = dist + 1
      end
    end

    raise 'No path found'
  end
end
