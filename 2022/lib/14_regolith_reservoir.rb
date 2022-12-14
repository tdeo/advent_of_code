# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

class RegolithReservoir
  extend T::Sig

  class Item < T::Enum
    enums do
      Floor = new('#')
      Sand = new('o')
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @map = T.let(
      Hash.new { |h, k| h[k] = {} },
      T::Hash[Integer, T::Hash[Integer, Item]],
    )
    @input.split("\n").each do |line|
      positions = line.split(' -> ')
      positions.each_cons(2) do |start, finish|
        j1, i1 = T.cast(T.must(start).split(',').map(&:to_i), [Integer, Integer])
        j2, i2 = T.cast(T.must(finish).split(',').map(&:to_i), [Integer, Integer])
        i1, i2 = i2, i1 if i1 > i2
        j1, j2 = j2, j1 if j1 > j2

        (i1..i2).each do |i|
          (j1..j2).each do |j|
            T.must(@map[i])[j] = Item::Floor
          end
        end
      end
    end
    @source = T.let([0, 500], [Integer, Integer])
  end

  sig { void }
  def debug
    jmin = T.let(500, T.nilable(Integer))
    jmax = T.let(500, T.nilable(Integer))
    @map.each_value do |val|
      a, b = val.keys.minmax
      next if a.nil?

      jmin = [jmin, a].min
      jmax = [jmax, b].max
    end

    imin, imax = @map.keys.minmax
    (imin..imax).each do |i|
      puts((jmin..jmax).map do |j|
        if @map[i] && T.must(@map[i])[j]
          T.must(T.must(@map[i])[j]).serialize
        else
          ' '
        end
      end.join)
    end
  end

  sig { returns(T::Boolean) }
  def pour_one_sand
    i, j = @source.dup
    limit = T.must(@map.keys.max)
    while i <= limit
      if !T.must(@map[i + 1])[j]
        i += 1
      elsif !T.must(@map[i + 1])[j - 1]
        i += 1
        j -= 1
      elsif !T.must(@map[i + 1])[j + 1]
        i += 1
        j += 1
      else
        T.must(@map[i])[j] = Item::Sand
        return true
      end
    end

    false
  end

  sig { returns(Integer) }
  def part1
    count = 0
    count += 1 while pour_one_sand
    count
  end

  sig { returns(Integer) }
  def part2
    ground = T.must(@map.keys.max) + 2
    @map[ground] = Hash.new(Item::Floor)

    count = 0
    loop do
      raise 'Pour does not finish' unless pour_one_sand

      count += 1
      break if T.must(@map[0])[500] == Item::Sand
    end
    count
  end
end
