# frozen_string_literal: true

require 'set'

class ThermoelectricGenerators
  def initialize(input)
    @elevator = 1
    @queued = Set.new
    @queue = []
    @initial = Hash.new { |h, k| h[k] = {} }
    input.split("\n").each_with_index do |line, i|
      line.scan(/\b([a-z]+) generator/).each do |elem|
        @initial[elem][:gen] = i + 1
      end
      line.scan(/\b([a-z]+)-compatible microchip/).each do |elem|
        @initial[elem][:chip] = i + 1
      end
    end
  end

  def hash(opt, ele)
    (opt.each_slice(2).sort.map { |e| e.map(&:to_s).join(',') } << ele.to_s).join('|')
  end

  def valid?(opt)
    (0...opt.size / 2).each do |i|
      (0...opt.size / 2).each do |j|
        return false if i != j && opt[2 * i] != opt[(2 * i) + 1] && opt[2 * j] == opt[(2 * i) + 1]
      end
    end
    true
  end

  def queued?(opt, ele)
    @queued.include?(hash(opt, ele))
  end

  def queue!(opt, ele, moves)
    return if queued?(opt, ele)

    @queue << [opt, ele, moves] if valid?(opt)
    @queued << hash(opt, ele)
  end

  def win?(opt)
    opt.minmax == [4, 4]
  end

  def moves(situation, ele)
    destinations = case ele
                   when 1 then [2]
                   when 4 then [3]
                   else [ele - 1, ele + 1]
                   end
    destinations.each do |d|
      situation.size.times do |i|
        situation.size.times do |j|
          next unless situation[i] == ele && situation[j] == ele

          option = situation.dup
          option[i] = d
          option[j] = d
          yield option, d
        end
      end
    end
  end

  def execute!
    until @queue.empty?
      sit, ele, moves = @queue.shift
      return moves if win?(sit)

      moves(sit, ele) { |a, b| queue!(a, b, moves + 1) }
    end
    nil
  end

  def part1
    queue!(@initial.flat_map { |_, v| [v[:gen], v[:chip]] }, 1, 0)
    execute!
  end

  def part2
    queue!(@initial.flat_map { |_, v| [v[:gen], v[:chip]] } + [1, 1, 1, 1], 1, 0)
    execute!
  end
end
