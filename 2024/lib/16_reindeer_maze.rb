# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'
require_relative '../../lib/priority_queue'

class ReindeerMaze < Map
  extend T::Sig

  class Dir < T::Enum
    enums do
      EAST = new
      NORTH = new
      SOUTH = new
      WEST = new
    end
  end

  Elem = type_member { { fixed: String } }
  QueuElem = T.type_alias { T.nilable([Integer, Cell[String], Dir]) }

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    super { _1 }
    @start = T.let(T.must(find { _1 == 'S' }), Map::Cell[String])
    @target = T.let(T.must(find { _1 == 'E' }), Map::Cell[String])
  end

  sig { params(elem: QueuElem).returns(QueuElem) }
  def straight(elem)
    return nil unless elem

    cost, cell, dir = elem
    next_cell = case dir
                when Dir::NORTH
                  cell.above
                when Dir::SOUTH
                  cell.below
                when Dir::EAST
                  cell.right
                when Dir::WEST
                  cell.left
                else
                  T.absurd(dir)
                end
    return nil unless next_cell

    [cost + 1, next_cell, dir]
  end

  sig { params(elem: QueuElem).returns(QueuElem) }
  def clockwise(elem)
    return nil unless elem

    cost, cell, dir = elem
    [cost + 1000, cell,
     case dir
     when Dir::NORTH then Dir::EAST
     when Dir::EAST then Dir::SOUTH
     when Dir::SOUTH then Dir::WEST
     when Dir::WEST then Dir::NORTH
     end,]
  end

  sig { params(elem: QueuElem).returns(QueuElem) }
  def anticlockwise(elem)
    return nil unless elem

    cost, cell, dir = elem
    [cost + 1000, cell,
     case dir
     when Dir::EAST then Dir::NORTH
     when Dir::SOUTH then Dir::EAST
     when Dir::WEST then Dir::SOUTH
     when Dir::NORTH then Dir::WEST
     end,]
  end

  sig { returns(Integer) }
  def part1
    q = T.let(
      PriorityQueue.new,
      PriorityQueue[QueuElem],
    )
    q << [0, @start, Dir::EAST]
    visited = T.let(Set.new([@start.coords, Dir::EAST]), T::Set[[[Integer, Integer], Dir]])

    until q.empty?
      elem = T.must(q.pop)
      cost, cell, _dir = elem
      return cost if cell == @target

      [straight(elem), clockwise(elem), anticlockwise(elem)].each do |succ|
        next unless succ
        next if visited.include?([succ[1].coords, succ[2]])

        visited << [succ[1].coords, succ[2]]

        q << succ if succ[1].value != '#'
      end
    end
    0
  end

  sig do
    params(
      reached_from: T::Hash[[[Integer, Integer], Dir], T::Array[[[Integer, Integer], Dir]]],
    ).returns(Integer)
  end
  def visited_cells(reached_from)
    cells = T.let(Set.new, T::Set[[[Integer, Integer], Dir]])
    q = T.let([], T::Array[[[Integer, Integer], Dir]])
    q << [@target.coords, Dir::EAST] <<
      [@target.coords, Dir::WEST] <<
      [@target.coords, Dir::NORTH] <<
      [@target.coords, Dir::SOUTH]

    until q.empty?
      head = T.must(q.pop)
      next if cells.include?(head)

      cells << head
      q.concat(T.must(reached_from[head])) if reached_from[head]
    end

    cells.map(&:first).uniq.size
  end

  sig { returns(Integer) }
  def part2
    reached_cost = T.let({}, T::Hash[[[Integer, Integer], Dir], Integer])
    reached_from = T.let({}, T::Hash[[[Integer, Integer], Dir], T::Array[[[Integer, Integer], Dir]]])

    q = T.let(
      PriorityQueue.new,
      PriorityQueue[QueuElem],
    )
    q << [0, @start, Dir::EAST]
    visited = T.let(Set.new([@start.coords, Dir::EAST]), T::Set[[[Integer, Integer], Dir]])

    winning_cost = T.let(nil, T.nilable(Integer))

    until q.empty?
      elem = T.must(q.pop)
      cost, cell, dir = elem
      winning_cost = cost if cell == @target
      break if winning_cost && winning_cost < cost
      next if visited.include?([cell.coords, dir])

      visited << [cell.coords, dir]
      [straight(elem), clockwise(elem), anticlockwise(elem)].each do |succ|
        next if succ.nil? || succ[1].value == '#'

        key = [succ[1].coords, succ[2]]
        if reached_cost[key].nil? || succ[0] <= T.must(reached_cost[key])
          reached_cost[key] = succ[0]
          reached_from[key] ||= []
          reached_from[key] = [] if T.must(reached_cost[key]) > succ[0]
          T.must(reached_from[key]) << [cell.coords, dir]
        end

        q << succ
      end
    end

    visited_cells(reached_from)
  end
end
