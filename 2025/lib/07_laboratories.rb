# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'

class Laboratories < Map
  extend T::Sig

  Elem = type_member { { fixed: String } }

  sig { params(input: String).void }
  def initialize(input)
    super { _1 }
    @start = T.let(T.must(find { _1 == 'S' }), Cell[Elem])
  end

  sig { params(part2: T::Boolean).returns(Integer) }
  def part1(part2: false)
    split_count = 0
    queue = T.let([@start], T::Array[Cell[Elem]])
    timelines = T.let({ @start.coords => 1 }, T::Hash[Coords, Integer])

    while (current = queue.shift)
      next if value_at(*current.coords) == '|'

      set(*current.coords, '|')
      next unless (below = current.below)

      case below.value
      when '.'
        timelines[below.coords] = timelines[below.coords].to_i + timelines[current.coords].to_i
        queue << below
      when '|'
        timelines[below.coords] = timelines[below.coords].to_i + timelines[current.coords].to_i
      when '^'
        split_count += 1
        queue << T.must(below.left) if below.left
        queue << T.must(below.right) if below.right
        timelines[T.must(below.left).coords] =
          timelines[T.must(below.left).coords].to_i + timelines[current.coords].to_i
        timelines[T.must(below.right).coords] =
          timelines[T.must(below.right).coords].to_i + timelines[current.coords].to_i
      end
    end

    total = T.let((0...@width).sum { |j| timelines[[@height - 1, j]].to_i }, Integer)
    return total if part2

    split_count
  end

  sig { returns(Integer) }
  def part2
    part1(part2: true)
  end
end
