# frozen_string_literal: true

class ConwayCubes
  ACTIVE = '#'
  INACTIVE = '.'

  def initialize(input)
    @input = input
    @dimension = nil
  end

  def parse
    raise unless @dimension

    @map = {}

    @ranges = Array.new(@dimension) { [0, 0] }
    @active = 0

    @input.each_line.each_with_index do |line, x|
      line.each_char.each_with_index do |c, y|
        next unless c == ACTIVE

        pos = [x, y]
        pos << 0 while pos.size < @dimension
        @active += 1
        @map[pos] = true
        @ranges.each_with_index do |range, i|
          range[0] = [range[0], pos[i]].min
          range[1] = [range[1], pos[i]].max
        end
      end
    end
  end

  def active_neighbours(pos)
    flat = pos.map { |c| [c - 1, c, c + 1] }

    r = 0
    flat[0].product(*flat[1..]).each do |pos2|
      r += 1 if @map[pos2]
    end

    r -= 1 if @map[pos]
    r
  end

  def iterate_many(range, *ranges)
    if ranges.empty?
      range.each do |item|
        yield item
      end
      return
    end

    iterate_many(*ranges) do |items|
      range.each do |item|
        yield [item, *items]
      end
    end
  end

  def step!
    succ = {}
    succ_ranges = Array.new(@dimension) { [nil, nil] }
    succ_active = 0

    flat = @ranges.map { |r| (r[0] - 1..r[1] + 1) }

    iterate_many(*flat) do |pos|
      succ[pos] = if @map[pos]
                    (2..3).cover?(active_neighbours(pos))
                  else
                    active_neighbours(pos) == 3
                  end

      next unless succ[pos]

      succ_active += 1
      succ_ranges.each_with_index do |range, i|
        range[0] = [range[0], pos[i]].compact.min
        range[1] = [range[1], pos[i]].compact.max
      end
    end

    @ranges = succ_ranges
    @active = succ_active
    @map = succ
  end

  def part1
    @dimension = 3
    parse
    6.times { step! }
    @active
  end

  def part2
    @dimension = 4
    parse
    6.times { step! }
    @active
  end
end
