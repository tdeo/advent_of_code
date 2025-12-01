# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'

class StepCounter < Map
  extend T::Sig

  class CellValue < T::Enum
    enums do
      Start = new('S')
      Garden = new('.')
      Rock = new('#')
    end
  end

  Elem = type_member { { fixed: CellValue } }

  sig { params(input: String).void }
  def initialize(input)
    super { CellValue.deserialize(_1) }
    @input = input
    @start = T.let(T.must(find { _1 == CellValue::Start }), Cell[Elem])
  end

  sig { params(start: Cell[Elem]).returns(T::Hash[Coords, Integer]) }
  def distances_from(start)
    q = T.let([], T::Array[Cell[Elem]])
    viewed = T.let({}, T::Hash[Coords, Integer])
    q << start
    viewed[start.coords] = 0

    until q.empty?
      cell = T.must(q.shift)
      dist = T.must(viewed[cell.coords])

      cell.neighbours.each do |n|
        next if viewed.key?(n.coords)
        next if n.value == CellValue::Rock

        viewed[n.coords] = dist + 1
        q << n
      end
    end

    viewed
  end

  sig { params(steps: Integer, from: Cell[Elem]).returns(Integer) }
  def part1(steps = 64, from = @start)
    distances = distances_from(from)
    distances.each_value.count { _1 <= steps && (steps - _1).even? }
  end

  sig { params(steps: Integer).returns(Integer) }
  def part2(steps = 26_501_365)
    i, j = @start.coords
    (0...@width).each { raise if at(_1, j)&.value == CellValue::Rock }
    (0...@height).each { raise if at(i, _1)&.value == CellValue::Rock }

    distances_from(@start)
    steps2 = steps % (@width + @height)
    part1(steps2, @start)

    0
  end
end
