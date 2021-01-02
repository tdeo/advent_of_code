# frozen_string_literal: true

class RainRisk
  EAST = 'E'
  WEST = 'W'
  NORTH = 'N'
  SOUTH = 'S'

  def initialize(input)
    @input = input
    @moves = @input.each_line.map do |l|
      [l[0], l[1..].to_i]
    end
    @pos = [0, 0] # east, north
    @wp = [10, 1]
    @dir = EAST
  end

  def n(count)
    @pos[1] += count
  end

  def s(count)
    @pos[1] -= count
  end

  def e(count)
    @pos[0] += count
  end

  def w(count)
    @pos[0] -= count
  end

  def r(count)
    dirs = [NORTH, EAST, SOUTH, WEST]
    idx = dirs.index(@dir)
    idx += (count / 90)
    idx = ((idx % 4) + 4) % 4
    @dir = dirs[idx]
  end

  def l(count)
    r(-count)
  end

  def f(count)
    case @dir
    when EAST then e(count)
    when WEST then w(count)
    when NORTH then n(count)
    when SOUTH then s(count)
    end
  end

  def perform(dir, count)
    send(dir.downcase.to_sym, count)
  end

  def manhattan
    @pos.sum(&:abs)
  end

  def part1
    @moves.each do |dir, count|
      perform(dir, count)
    end
    manhattan
  end

  def n2(count)
    @wp[1] += count
  end

  def s2(count)
    @wp[1] -= count
  end

  def e2(count)
    @wp[0] += count
  end

  def w2(count)
    @wp[0] -= count
  end

  def f2(count)
    @pos[0] += count * @wp[0]
    @pos[1] += count * @wp[1]
  end

  def l2(count)
    return l2(count + 360) if count < 0
    return if count == 0

    @wp = [-@wp[1], @wp[0]]
    l2(count - 90)
  end

  def r2(count)
    l2(-count)
  end

  def part2
    @moves.each do |dir, count|
      send(:"#{dir.downcase}2", count)
    end
    # puts @pos.inspect, @wp.inspect
    manhattan
  end
end
