# frozen_string_literal: true

require 'set'

class PassagePathing
  START = 'start'
  FINISH = 'end'

  def initialize(input)
    @input = input
    @neighbours = Hash.new { |hash, key| hash[key] = Set.new }
    @input.split("\n").each do |line|
      a, b = line.split('-')
      @neighbours[a] << b
      @neighbours[b] << a
    end
    @neighbours.each_value { _1.delete('start') }
    @neighbours[FINISH] = Set.new
  end

  def successors(path)
    res = []
    @neighbours[path[-1]].each do |succ|
      path = path.dup
      if succ =~ /^[a-z]+$/ && path.include?(succ)
        next if path[0] == true

        res << [true, *path[1..], succ]
      else
        res << path + [succ]
      end
    end
    res
  end

  def part1(can_dupe: true)
    paths = [[can_dupe, START]]
    to_finish = []

    loop do
      paths = paths.flat_map { successors(_1) }
      paths.delete_if do |path|
        if path[-1] == FINISH
          to_finish << path[1..]
          true
        end
      end
      break if paths.empty?
    end

    to_finish.size
  end

  def part2
    part1(can_dupe: false)
  end
end
