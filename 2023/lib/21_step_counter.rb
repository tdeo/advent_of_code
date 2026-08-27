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
    raise 'grid is not square' unless @height == @width
    raise 'uncentered start' unless @start.coords[0] == @start.coords[1]
    raise 'uncentered start' unless (@start.coords[0] * 2) + 1 == @height

    a = steps % @width
    final_i = steps / @width

    first_values = (0..2).map do |i|
      steps = (i * @width) + a
      k = (2 * i) + 1
      new_input = @input.lines(chomp: true).map do |line|
        line.tr('S', '.') * k
      end
      new_input = k.times.flat_map { new_input.map(&:dup) }
      T.must(new_input[new_input.size / 2])[new_input.size / 2] = 'S'
      solver = self.class.new(new_input.join("\n"))
      res = solver.part1(steps)
      res
    end

    v0 = first_values[0].to_i
    v1 = first_values[1].to_i
    v2 = first_values[2].to_i
    # the equation should be polynomial: val = a*i^2 + b*i + c
    # with i = 0, 1, 2, we have:
    # v0 = c
    # v1 = a + b + c
    # v2 = 4a + 2b + c
    # easily enough:
    c = v0
    # v2 - 2 * v1 = 2a - c, so:
    a = (v2 - (2 * v1) + c) / 2
    b = v1 - a - c

    (a * final_i * final_i) + (b * final_i) + c
  end
end
