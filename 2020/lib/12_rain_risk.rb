class RainRisk
  EAST = 'E'
  WEST = 'W'
  NORTH = 'N'
  SOUTH = 'S'

  def initialize(input)
    @input = input
    @moves = @input.each_line.map do |l|
      [l[0], l[1..-1].to_i]
    end
    @pos = [0, 0] # east, north
    @wp = [10, 1]
    @dir = EAST
  end

  def N(count)
    @pos[1] += count
  end

  def S(count)
    @pos[1] -= count
  end

  def E(count)
    @pos[0] += count
  end

  def W(count)
    @pos[0] -= count
  end

  def R(count)
    dirs = [NORTH, EAST, SOUTH, WEST]
    idx = dirs.index(@dir)
    idx += (count / 90)
    idx = ((idx % 4) + 4) % 4
    @dir = dirs[idx]
  end

  def L(count)
    R(-count)
  end

  def F(count)
    case @dir
    when EAST then E(count)
    when WEST then W(count)
    when NORTH then N(count)
    when SOUTH then S(count)
    end
  end

  def perform(dir, count)
    send(dir.to_sym, count)
  end

  def manhattan
    @pos.map(&:abs).sum
  end

  def part1
    @moves.each do |dir, count|
      perform(dir, count)
    end
    manhattan
  end

  def N2(count)
    @wp[1] += count
  end

  def S2(count)
    @wp[1] -= count
  end

  def E2(count)
    @wp[0] += count
  end

  def W2(count)
    @wp[0] -= count
  end

  def F2(count)
    @pos[0] += count * @wp[0]
    @pos[1] += count * @wp[1]
  end

  def L2(count)
    return L2(count + 360) if count < 0
    return if count == 0

    @wp = [-@wp[1], @wp[0]]
    L2(count - 90)
  end

  def R2(count)
    L2(-count)
  end

  def part2
    @moves.each do |dir, count|
      send(:"#{dir}2", count)
    end
    # puts @pos.inspect, @wp.inspect
    manhattan
  end
end
