# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class NeverTellMeTheOdds
  extend T::Sig

  class Stone < T::Struct
    extend T::Sig

    const :x, Integer
    const :y, Integer
    const :z, Integer
    const :vx, Integer
    const :vy, Integer
    const :vz, Integer

    sig { params(input: String).returns(Stone) }
    def self.parse(input)
      x, y, z, _at, vx, vy, vz = input.split
      new(x: x.to_i, y: y.to_i, z: z.to_i, vx: vx.to_i, vy: vy.to_i, vz: vz.to_i)
    end

    sig { returns([Integer, Integer, Integer]) }
    def eqn_coeff
      [vy, -vx, (vy * x) - (vx * y)]
    end

    sig { params(other: Stone).returns([Rational, Rational]) }
    def crosses_at(other)
      a1, b1, c1 = eqn_coeff
      a2, b2, c2 = other.eqn_coeff

      denominator = (a1 * b2) - (a2 * b1)
      raise 'parallel' if denominator == 0

      [
        Rational((c1 * b2) - (c2 * b1), denominator),
        Rational((a1 * c2) - (a2 * c1), denominator),
      ]
    end

    sig { params(inter: [Rational, Rational]).returns(Numeric) }
    def time_for(inter)
      return (inter[0] - x) / vx if vx != 0
      return (inter[1] - y) / vy if vy != 0

      Float::INFINITY
    end

    sig { returns(Vec3) }
    def position
      Vec3.new(x, y, z)
    end

    sig { returns(Vec3) }
    def velocity
      Vec3.new(vx, vy, vz)
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @stones = T.let(input.lines(chomp: true).map { Stone.parse(_1) }, T::Array[Stone])
  end

  sig { params(range: T::Range[Integer]).returns(Integer) }
  def part1(range: (200_000_000_000_000..400_000_000_000_000))
    @stones.combination(2).count do |stone1, stone2|
      stone1 = T.must(stone1)
      stone2 = T.must(stone2)
      inter = stone1.crosses_at(stone2)

      next false unless range.include?(inter[0]) && range.include?(inter[1])

      stone1.time_for(inter) >= 0 && stone2.time_for(inter) >= 0
    rescue StandardError
      false
    end
  end

  class Vec3
    extend T::Sig

    sig { returns(Numeric) }
    attr_reader :x, :y, :z

    sig { params(x: Numeric, y: Numeric, z: Numeric).void }
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
    end

    sig { params(other: Vec3).returns(Vec3) }
    def cross(other)
      Vec3.new((@y * other.z) - (@z * other.y), (@z * other.x) - (@x * other.z), (@x * other.y) - (@y * other.x))
    end

    sig { params(other: Vec3).returns(Numeric) }
    def dot(other)
      (@x * other.x) + (@y * other.y) + (@z * other.z)
    end

    sig { params(other: Numeric).returns(Vec3) }
    def *(other)
      Vec3.new(@x * other, @y * other, @z * other)
    end

    sig { params(other: Vec3).returns(Vec3) }
    def -(other)
      Vec3.new(@x - other.x, @y - other.y, @z - other.z)
    end

    sig { params(other: Vec3).returns(Vec3) }
    def +(other)
      Vec3.new(@x + other.x, @y + other.y, @z + other.z)
    end
  end

  sig { returns(Integer) }
  def part2
    s0 = T.must(@stones[0])
    s1 = T.must(@stones[1])
    s2 = T.must(@stones[2])

    # work in the referential of stone 0, looking at collisions with stones 1 and 2
    p1 = s1.position - s0.position
    p2 = s2.position - s0.position
    v1 = s1.velocity - s0.velocity
    v2 = s2.velocity - s0.velocity

    # let's say collisions happen at t1, t2, so at positions p1 + t1*v1 and p2 + t2*v2
    # Those are colinear, hence (p1+t1*v1) x (p2+t2*v2) = 0
    # expand to : (p1 x p2) + t1*(v1 x p2) + t2*(p1 x v2) + t1*t2*(v1 x v2) = 0
    # dot product with v1: (p1 x p2).v1 + t2*(p1 x v2).v1 = 0 (other terms are zero)
    # dot product with v2: (p1 x p2).v2 + t1*(v1 x p2).v2 = 0 (other terms are zero)
    # So:
    # t1 = -((p1 x p2).v2 / (v1 x p2).v2)
    # t2 = -((p1 x p2).v1 / (p1 x v2).v1)
    t1 = Rational(- p1.cross(p2).dot(v2), v1.cross(p2).dot(v2))
    t2 = Rational(- p1.cross(p2).dot(v1), p1.cross(v2).dot(v1))

    # collisions happen at those coordinates:
    c1 = s1.position + (s1.velocity * t1)
    c2 = s2.position + (s2.velocity * t2)

    # so we can compute:
    velocity = (c2 - c1) * Rational(1, t2 - t1)
    position = c1 - (velocity * t1)

    (position.x + position.y + position.z).to_i
  end
end
