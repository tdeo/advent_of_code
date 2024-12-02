# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class IfYouGiveASeedAFertilizer
  extend T::Sig

  class Map
    extend T::Sig

    sig { returns(Symbol) }
    attr_reader :from, :to

    sig { params(from: Symbol, to: Symbol).void }
    def initialize(from, to)
      @ranges = T.let([], T::Array[[Integer, Integer, Integer]])
      @from = from
      @to = to
    end

    sig { params(from: Integer, to: Integer, size: Integer).void }
    def add_range(from, to, size)
      @ranges << [from, to, size]
      @ranges.sort_by! { _1[1] }
    end

    sig { params(val: Integer).returns(Integer) }
    def value_for(val)
      range = @ranges.find { val >= _1[1] && val < _1[1] + _1[2] }
      return val if range.nil?

      range[0] + (val - range[1])
    end

    sig { params(value: Integer).returns([Integer, Integer, T.any(Integer, Float)]) }
    def range_for(value)
      range = @ranges.find { value >= _1[1] && value < _1[1] + _1[2] }
      return range unless range.nil?

      idx = @ranges.find_index { _1[1] > value }
      return [value, value, T.must(@ranges[idx])[1] - value] if idx

      [value, value, Float::INFINITY]
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    lines = @input.split("\n")
    @seeds = T.let(
      T.must(T.must(lines.shift).split(': ').last).split.map(&:to_i),
      T::Array[Integer],
    )
    @maps = T.let([], T::Array[Map])
    lines.each do |line|
      case line
      when /(\w+)-to-(\w+) map:/
        @maps << Map.new(
          T.must(T.must(Regexp.last_match)[1]).to_sym,
          T.must(T.must(Regexp.last_match)[2]).to_sym,
        )
      when /\d+ \d+ \d+/
        from, to, size = line.split.map(&:to_i)
        T.must(@maps.last).add_range(T.must(from), T.must(to), T.must(size))
      end
    end
  end

  sig { params(seed: Integer).returns(Integer) }
  def value(seed)
    cur_type = :seed
    value = seed
    while cur_type != :location
      map = @maps.find { _1.from == cur_type }
      raise unless map

      cur_type = map.to
      value = map.value_for(value)
    end
    value
  end

  sig { returns(Integer) }
  def part1
    @seeds.map { value(_1) }.min || 0
  end

  sig { params(ranges: T::Array[[Integer, Integer]], type: Symbol).returns(T::Array[[Integer, Integer]]) }
  def next_ranges(ranges, type:)
    map = T.must(@maps.find { _1.from == type })

    res = T.let([], T::Array[[Integer, Integer]])
    until ranges.empty?
      head = T.must(ranges.shift)
      mapping = map.range_for(head[0])

      size = [mapping[1] + mapping[2] - head[0], head[1]].min
      res << [mapping[0] + head[0] - mapping[1], size.to_i]
      ranges.unshift [(head[0] + size).to_i, (head[1] - size).to_i] if size < head[1]
    end

    res
  end

  sig { returns(Integer) }
  def part2
    type = T.let(:seed, Symbol)
    ranges = @seeds.each_slice(2).map do |a, b|
      [T.must(a), T.must(b)]
    end
    while type != :location
      map = T.must(@maps.find { _1.from == type })
      ranges = next_ranges(ranges, type: type)
      type = map.to
    end
    T.must(ranges.map(&:first).min)
  end
end
