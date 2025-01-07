# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class BeaconScanner
  extend T::Sig

  Coords = T.type_alias { [Integer, Integer, Integer] }

  class Scanner
    extend T::Sig

    sig { returns(String) }
    attr_reader :name

    sig { returns(Coords) }
    attr_reader :center

    sig { returns(T::Array[Coords]) }
    attr_reader :coords

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      @coords = T.let([], T::Array[Coords])
      @name = T.let(T.must(@input.lines[0]).tr('-', '').strip, String)
      @input.lines(chomp: true).drop(1).each do |line|
        a, b, c = line.split(',')
        @coords << [a.to_i, b.to_i, c.to_i]
      end
      @aligned = T.let(false, T::Boolean)
      @center = T.let([0, 0, 0], Coords)
    end

    sig { params(a: Coords, b: Coords).returns(Integer) }
    def distance(a, b)
      a.zip(b).sum do |c1, c2|
        (T.must(c2) - c1).abs**3
      end.to_i
    end

    sig { returns(T::Array[Integer]) }
    def distances
      @distances ||= T.let(@coords.combination(2).map do |a, b|
        distance(T.must(a), T.must(b))
      end, T.nilable(T::Array[Integer]),)
    end

    sig { params(dist: Integer).returns([Coords, Coords]) }
    def pair_for(dist)
      res = @coords.combination(2).find do |a, b|
        distance(T.must(a), T.must(b)) == dist
      end

      res = T.must(res)
      [T.must(res[0]), T.must(res[1])]
    end

    sig { params(other: Scanner).returns(T::Array[Coords]) }
    def common_stars(other)
      (distances & other.distances).flat_map { pair_for(_1) }.uniq
    end

    sig { params(other: Scanner).void }
    def align_with!(other)
      raise 'Ambiguous distance' if other.distances.uniq.size != other.distances.size
      raise 'Ambiguous distance' if distances.uniq.size != distances.size

      swap_axis!(other)
      reverse_axis!(other)
      translate!(other)
      aligned!
    end

    sig { void }
    def aligned!
      @aligned = true
    end

    sig { returns(T::Boolean) }
    def aligned?
      @aligned
    end

    sig { params(other: Scanner).void }
    def translate!(other)
      a1 = T.must(common_stars(other).min).dup
      a2 = T.must(other.common_stars(self).min).dup

      @center[0] += a2[0] - a1[0]
      @center[1] += a2[1] - a1[1]
      @center[2] += a2[2] - a1[2]

      @coords.each do |coord|
        coord[0] += a2[0] - a1[0]
        coord[1] += a2[1] - a1[1]
        coord[2] += a2[2] - a1[2]
      end
    end

    sig { params(other: Scanner).void }
    def reverse_axis!(other)
      set1 = common_stars(other)
      set2 = other.common_stars(self)
      (0..2).each do |i|
        s1 = set1.map { T.must(_1[i]) }.sort
        s2 = set2.map { T.must(_1[i]) }.sort
        m1 = s1[0]
        m2 = s2[0]
        s1 = s1.map! { _1 - T.must(m1) }
        s2 = s2.map! { _1 - T.must(m2) }

        reverse!(i) unless s1 == s2
      end
    end

    sig { params(other: Scanner).void }
    def swap_axis!(other)
      dist = T.must((distances & other.distances).first)
      a1, b1 = pair_for(dist)
      a2, b2 = other.pair_for(dist)
      raise unless a1.zip(b1).map { |a, b| (b.to_i - a).abs }.uniq.size == 3

      case (a2[0] - b2[0]).abs
      when (a1[1] - b1[1]).abs then swap!(1, 0)
      when (a1[2] - b1[2]).abs then swap!(2, 0)
      end
      swap!(1, 2) if (a2[1] - b2[1]).abs == (a1[2] - b1[2]).abs
    end

    sig { params(i: Integer).void }
    def reverse!(i)
      @coords.each do |coord|
        coord[i] = -T.must(coord[i])
      end
    end

    sig { params(i: Integer, j: Integer).void }
    def swap!(i, j)
      @coords.each do |coord|
        a = T.must(coord[i])
        coord[i] = T.must(coord[j])
        coord[j] = a
      end
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @scanners = T.let([], T::Array[Scanner])
    @input.split("\n\n").each { @scanners << Scanner.new(_1) }
  end

  sig { returns(Integer) }
  def part1
    @scanners.first&.aligned!

    until @scanners.all?(&:aligned?)
      @scanners.permutation(2) do |b1, b2|
        b1 = T.must(b1)
        b2 = T.must(b2)

        next unless b1.aligned? && !b2.aligned?
        next unless (b1.distances & b2.distances).size >= 66

        b2.align_with!(b1)
      end
    end

    @scanners.flat_map(&:coords).uniq.size
  end

  sig { returns(Integer) }
  def part2
    part1

    T.must(@scanners.combination(2).map do |s1, s2|
      c1 = T.must(s1).center
      c2 = T.must(s2).center
      c2.zip(c1).sum do |a, b|
        (T.must(b) - a).abs
      end
    end.max)
  end
end
