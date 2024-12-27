# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/map'

class RaceCondition < Map
  extend T::Sig

  Elem = type_member { { fixed: String } }

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    super { _1 }
    @start = T.let(T.must(find { _1 == 'S' }), Cell[String])
    @end = T.let(T.must(find { _1 == 'E' }), Cell[String])
    @start_dist = T.let({ @start.coords => 0 }, T::Hash[Coords, Integer])
    @end_dist = T.let({ @end.coords => 0 }, T::Hash[Coords, Integer])
  end

  sig { void }
  def compute_distances!
    q = [@start]
    until q.empty?
      h = T.must(q.shift)
      h.neighbours.each do |n|
        next if @start_dist.key?(n.coords)
        next if n.value == '#'

        @start_dist[n.coords] = T.must(@start_dist[h.coords]) + 1
        q << n
      end
    end

    q = [@end]
    until q.empty?
      h = T.must(q.shift)
      h.neighbours.each do |n|
        next if @end_dist.key?(n.coords)
        next if n.value == '#'

        @end_dist[n.coords] = T.must(@end_dist[h.coords]) + 1
        q << n
      end
    end
  end

  sig { params(saves_at_least: Integer).returns(Integer) }
  def part1(saves_at_least: 100)
    part2(cheat_size: 2, saves_at_least: saves_at_least)
  end

  sig { params(cheat_size: Integer, saves_at_least: Integer).returns(Integer) }
  def part2(cheat_size: 20, saves_at_least: 100)
    compute_distances!
    original_dist = T.must(@start_dist[@end.coords])

    significant_shortcuts = 0
    cells.each do |cell|
      i, j = cell.coords
      next unless @start_dist[cell.coords]

      (-cheat_size..cheat_size).each do |di|
        (-cheat_size + di.abs..cheat_size - di.abs).each do |dj|
          other = at(i + di, j + dj)
          next unless other && other.value != '#' && @end_dist[other.coords]

          dist = T.must(@end_dist[other.coords]) + T.must(@start_dist[cell.coords]) + di.abs + dj.abs
          next unless dist <= original_dist - saves_at_least

          significant_shortcuts += 1
        end
      end
    end
    significant_shortcuts
  end
end
