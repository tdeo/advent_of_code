# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Snowverload
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @nodes = T.let([], T::Array[String])
    @neighbors = T.let(Hash.new { |h, k| h[k] = [] }, T::Hash[String, T::Array[String]])
    @input.lines(chomp: true).each do |line|
      src, dests = line.split(': ')
      T.must(dests).split.each do |dest|
        T.must(@neighbors[T.must(src)]) << dest
        T.must(@neighbors[dest]) << T.must(src)
      end
    end
  end

  sig { params(start: String, goal: String).returns(T.nilable(T::Array[String])) }
  def shortest_path(start, goal)
    queue = [start]
    visited = T.let({ start => [start] }, T::Hash[String, T::Array[String]])
    while queue.any?
      current = T.must(queue.shift)

      return T.must(visited[current]) if current == goal

      @neighbors[current]&.each do |neighbor|
        next if visited.key?(neighbor)

        visited[neighbor] = T.must(visited[current]) + [neighbor]
        queue << neighbor
      end
    end

    nil
  end

  sig { params(a: String, b: String, blk: T.proc.void).void }
  def without_edge(a, b, &blk)
    @neighbors[a]&.delete(b)
    @neighbors[b]&.delete(a)
    yield
  ensure
    @neighbors[a]&.push(b)
    @neighbors[b]&.push(a)
  end

  sig { returns([[String, String], [String, String], [String, String]]) }
  def edges_to_remove
    @neighbors.each do |a, a_neighbors|
      a_neighbors.each do |b|
        without_edge(a, b) do
          shortest_path(a, b)&.each_cons(2) do |c, d|
            c = T.must(c)
            d = T.must(d)
            without_edge(c, d) do
              shortest_path(a, b)&.each_cons(2) do |e, f|
                e = T.must(e)
                f = T.must(f)
                without_edge(e, f) do
                  return [[a, b], [c, d], [e, f]] if shortest_path(a, b).nil?
                end
              end
            end
          end
        end
      end
    end

    raise 'no option'
  end

  sig { params(start: String).returns(Integer) }
  def group_size(start)
    q = [start]
    v = Set[start]
    while (current = q.shift)
      @neighbors[current]&.each do |neighbor|
        next if v.include?(neighbor)

        v << neighbor
        q << neighbor
      end
    end

    v.size
  end

  sig { returns(Integer) }
  def part1
    edges = edges_to_remove
    res = 0
    without_edge(*edges[0]) do
      without_edge(*edges[1]) do
        without_edge(*edges[2]) do
          res = group_size(edges[0][0]) * group_size(edges[0][1])
        end
      end
    end
    res
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
