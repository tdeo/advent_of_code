# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'

class GuardGallivant
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @map = T.let(Map.new(input, &:itself), Map[String])
  end

  sig { params(cell: Map::Cell[String]).returns(T.nilable(Map::Cell[String])) }
  def succ(cell)
    succ = case cell.value
           when '^' then cell.above
           when '>' then cell.right
           when '<' then cell.left
           when 'v' then cell.below
           end

    if succ&.value == '#'
      cell.value = case cell.value
                   when '^' then '>'
                   when '>' then 'v'
                   when 'v' then '<'
                   when '<' then '^'
                   else raise
                   end
      return cell
    end
    succ&.value = cell.value
    succ
  end

  sig { params(cell: Map::Cell[String]).returns(T::Boolean) }
  def loops?(cell)
    visited = Set.new
    current = T.let(cell, T.nilable(Map::Cell[String]))
    loop do
      return false if current.nil?
      return true if visited.include?([current.coords, current.value])

      visited << [current.coords, current.value]
      current = succ(current)
    end
  end

  sig { returns(T::Set[[Integer, Integer]]) }
  def path
    visited = T.let(Set.new, T::Set[[Integer, Integer]])
    current = T.let(@map.find { %w[^ < > v].include? _1 }, T.nilable(Map::Cell[String]))

    loop do
      break if current.nil?

      visited << current.coords
      current = succ(current)
    end
    visited
  end

  sig { returns(Integer) }
  def part1
    path.size
  end

  sig { returns(Integer) }
  def part2
    initial = T.must(@map.find { %w[^ < > v].include? _1 })
    i0, j0 = initial.coords

    blocks = T.let(Set.new, T::Set[[Integer, Integer]])
    path.each do |option|
      i, j = option

      char_was = @map.value_at(i, j)
      @map.set(i, j, '#')
      blocks << option if loops?(T.must(@map.at(i0, j0)))
      @map.set(i, j, T.must(char_was))
    end

    blocks.delete(initial.coords)
    blocks.size
  end
end
