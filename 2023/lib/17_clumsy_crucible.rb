# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/priority_queue'
require_relative '../../lib/map'

class ClumsyCrucible < Map
  extend T::Sig

  Elem = type_member { { fixed: Integer } }

  class Dir < T::Enum
    enums do
      UP = new
      DOWN = new
      RIGHT = new
      LEFT = new
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    super(input, &:to_i)
    @input = input
  end

  QueueElem = T.type_alias { [Integer, Cell[Integer], Dir] }

  sig { params(el: QueueElem, min_moves: Integer, max_moves: Integer).returns(T::Array[QueueElem]) }
  def successors(el, min_moves:, max_moves:)
    val, cell, dir = el

    next_pos = T.let([], T::Array[[Integer, Cell[Integer]]])
    (1..max_moves).each do |i|
      succ = case dir
             when Dir::RIGHT then cell.right
             when Dir::LEFT then cell.left
             when Dir::UP then cell.above
             when Dir::DOWN then cell.below
             end
      break if succ.nil?

      cell = succ
      val += cell.value
      next_pos << [val, cell] if i >= min_moves
    end
    next_dirs = case dir
                when Dir::UP, Dir::DOWN then [Dir::LEFT, Dir::RIGHT]
                when Dir::LEFT, Dir::RIGHT then [Dir::UP, Dir::DOWN]
                end

    res = T.let([], T::Array[QueueElem])
    next_pos.each do |pos|
      next_dirs.each do |next_dir|
        res << [pos[0], pos[1], next_dir]
      end
    end
    res
  end

  sig { params(min_moves: Integer, max_moves: Integer).returns(Integer) }
  def part1(min_moves: 1, max_moves: 3)
    q = T.let(
      PriorityQueue.new,
      PriorityQueue[QueueElem],
    )
    q << [0, T.must(at(0, 0)), Dir::RIGHT]
    q << [0, T.must(at(0, 0)), Dir::DOWN]
    viewed = T.let({}, T::Hash[[[Integer, Integer], Dir], Integer])

    loop do
      head = T.must(q.pop)
      val, cell, dir = head
      return val if cell.coords == [@height - 1, @width - 1]

      k = [cell.coords, dir]
      next if viewed[k] && (T.must(viewed[k]) <= val)

      viewed[k] = val
      successors(head, min_moves: min_moves, max_moves: max_moves).each do |succ|
        q << succ
      end
    end
  end

  sig { returns(Integer) }
  def part2
    part1(min_moves: 4, max_moves: 10)
  end
end
