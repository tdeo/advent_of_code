# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'

class PrintingDepartment < Map
  extend T::Sig

  Elem = type_member { { fixed: String } }

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    super { _1 }
  end

  sig { returns(T::Array[Cell[Elem]]) }
  def removable_cells
    cells.select do |cell|
      cell.value == '@' && cell.neighbours(diagonals: true).count { _1.value == '@' } < 4
    end
  end

  sig { returns(Integer) }
  def part1
    removable_cells.size
  end

  sig { returns(Integer) }
  def part2
    to_check = removable_cells
    changed = 0
    until to_check.empty?
      cell = T.must(to_check.shift)
      next unless T.must(at(*cell.coords)).value == '@'

      neighbours = cell.neighbours(diagonals: true)
      next unless neighbours.count { _1.value == '@' } < 4

      changed += 1
      set(*cell.coords, '.')
      to_check.concat(neighbours)
    end
    changed
  end
end
