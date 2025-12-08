# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Playground
  extend T::Sig

  class Box
    extend T::Sig

    sig { returns(Integer) }
    attr_reader :x, :y, :z

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      x, y, z = input.split(',').map(&:to_i)
      @x = T.let(x.to_i, Integer)
      @y = T.let(y.to_i, Integer)
      @z = T.let(z.to_i, Integer)
    end

    sig { params(other: Box).returns(Numeric) }
    def dist(other)
      ((@x - other.x)**2) + ((@y - other.y)**2) + ((@z - other.z)**2)
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @boxes = T.let(input.each_line(chomp: true).map do |line|
      Box.new(line)
    end, T::Array[Box],)

    @ordered_pairs = T.let(T.cast(@boxes.combination(2).to_a, T::Array[[Box, Box]]), T::Array[[Box, Box]])
    @ordered_pairs.sort_by! { |a, b| a.dist(b) }
  end

  sig { params(a: Box, b: Box, groups: T::Array[T::Set[Box]]).void }
  def join(a, b, groups:)
    i1 = groups.find_index { |group| group.include?(a) }
    i2 = groups.find_index { |group| group.include?(b) }

    return if i1 && i1 == i2

    if i1 && i2
      groups[i1] = T.must(groups[i1]) | T.must(groups[i2])
      groups.delete_at(i2)
    elsif i1
      T.must(groups[i1]) << b
    elsif i2
      T.must(groups[i2]) << a
    else
      groups << Set.new([a, b])
    end
  end

  sig { params(count: Integer).returns(Integer) }
  def part1(count: 1000)
    groups = T.let([], T::Array[T::Set[Box]])
    @ordered_pairs.first(count).each do |a, b|
      join(a, b, groups: groups)
    end

    sizes = groups.map(&:size).sort
    (sizes[-3] || 1) * (sizes[-2] || 1) * (sizes[-1] || 1)
  end

  sig { returns(Integer) }
  def part2
    groups = T.let([], T::Array[T::Set[Box]])
    pairs = T.let(@ordered_pairs.dup, T::Array[[Box, Box]])
    last_pair = T.let(nil, T.nilable([Box, Box]))
    while groups.first&.size != @boxes.size
      last_pair = T.must(pairs.shift)
      join(*last_pair, groups: groups)
    end
    T.must(last_pair)[0].x * T.must(last_pair)[1].x
  end
end
