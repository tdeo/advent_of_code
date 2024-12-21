# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'

class RamRun < Map
  extend T::Sig

  Elem = type_member { { fixed: String } }

  sig { params(input: String, upto: Integer).void }
  def initialize(input, upto: 70)
    @input = input
    @upto = upto
    empty_map = "#{'.' * (upto + 1)}\n" * (upto + 1)
    super(empty_map) { _1 }
    @bytes = T.let(input.each_line(chomp: true).map do |line|
      a, b = line.split(',')
      [a.to_i, b.to_i]
    end, T::Array[[Integer, Integer]],)
  end

  sig { params(from: Coords, to: Coords).returns(Integer) }
  def distance(from, to)
    q = T.let([T.must(at(*from))], T::Array[Cell[String]])
    target = T.must(at(*to))
    dist = T.let({ from => 0 }, T::Hash[Coords, Integer])

    loop do
      h = q.shift
      raise if h.nil?

      d = T.must(dist[h.coords])
      return d if h == target

      h.neighbours.each do |n|
        next if n.value == '#'
        next if dist.key?(n.coords)

        dist[n.coords] = d + 1
        q << n
      end
    end
  end

  sig { params(byte_count: Integer).returns(Integer) }
  def part1(byte_count: 1024)
    @bytes.first(byte_count).each do |i, j|
      set(i, j, '#')
    end

    distance([0, 0], [@width - 1, @height - 1])
  end

  sig { returns(String) }
  def part2
    idx = (0...@bytes.size).to_a.bsearch do |k|
      begin
        (0..@upto).each do |i|
          (0..@upto).each do |j|
            set(i, j, '.')
          end
        end
        part1(byte_count: k + 1)
      rescue RuntimeError
        next true
      end
      false
    end
    T.must(@bytes[T.must(idx)]).join(',')
  end
end
