# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class ALongWalk
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @lines = T.let(input.lines(chomp: true).map(&:chars), T::Array[T::Array[String]])
    @start = T.let(
      [0, T.must(@lines.first&.find_index('.'))],
      [Integer, Integer],
    )
    @finish = T.let(
      [@lines.size - 1, T.must(@lines.last&.find_index('.'))],
      [Integer, Integer],
    )
    @intersections = T.let(Set[@start, @finish], T::Set[[Integer, Integer]])
    (1..(@lines.size - 2)).each do |i|
      (1..(T.must(@lines[i]).size - 2)).each do |j|
        neighbors = 0
        neighbors += 1 if T.must(@lines[i - 1]).at(j) != '#'
        neighbors += 1 if T.must(@lines[i + 1]).at(j) != '#'
        neighbors += 1 if T.must(@lines[i]).at(j - 1) != '#'
        neighbors += 1 if T.must(@lines[i]).at(j + 1) != '#'
        @intersections << [i, j] if neighbors > 2
      end
    end
    @neighboring_intersections = T.let({}, T::Hash[[Integer, Integer], T::Hash[[Integer, Integer], Integer]])
  end

  sig { params(i: Integer, j: Integer, blk: T.proc.params(i: Integer, j: Integer).void).void }
  def accessible_neighbors(i, j, &blk)
    yield i - 1, j if i > 0 && %w[. ^].include?(T.must(@lines[i - 1]).at(j))
    yield i + 1, j if i < @lines.size - 1 && %w[. v].include?(T.must(@lines[i + 1]).at(j))
    yield i, j - 1 if j > 0 && %w[. <].include?(T.must(@lines[i]).at(j - 1))
    yield i, j + 1 if j < T.must(@lines[i]).size - 1 && %w[. >].include?(T.must(@lines[i]).at(j + 1))
  end

  sig { params(i: Integer, j: Integer).returns(T::Hash[[Integer, Integer], Integer]) }
  def neighboring_intersections(i, j)
    return T.must(@neighboring_intersections[[i, j]]) if @neighboring_intersections.key?([i, j])

    q = [[i, j]]
    visited = T.let({ [i, j] => 0 }, T::Hash[[Integer, Integer], Integer])
    result = T.let({}, T::Hash[[Integer, Integer], Integer])
    until q.empty?
      current = T.must(q.shift)
      accessible_neighbors(*current) do |i2, j2|
        next if visited.key?([i2, j2])

        visited[[i2, j2]] = visited[current].to_i + 1
        if @intersections.include?([i2, j2])
          result[[i2, j2]] = visited[current].to_i + 1
        else
          q << [i2, j2]
        end
      end
    end

    @neighboring_intersections[[i, j]] = result
  end

  sig { params(start: [Integer, Integer], finish: [Integer, Integer], seen: T::Set[[Integer, Integer]], current_dist: Integer).returns(T.nilable(Integer)) }
  def longest_path(start, finish, seen: Set[@start], current_dist: 0)
    neighboring_intersections(*start).filter_map do |intersection, distance|
      next if seen.include?(intersection)

      return current_dist + distance if intersection == finish

      seen << intersection
      r = longest_path(intersection, finish, seen: seen, current_dist: current_dist + distance)
      seen.delete(intersection)
      r
    end.max
  end

  sig { returns(Integer) }
  def part1
    T.must(longest_path(@start, @finish))
  end

  sig { returns(Integer) }
  def part2
    @lines.each do |line|
      line.each_with_index do |char, j|
        line[j] = '.' if char != '#'
      end
    end
    part1
  end
end
