# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class BoilingBoulders
  extend T::Sig

  Cube = T.type_alias { [Integer, Integer, Integer] }
  class Face < T::Enum
    enums do
      Top = new
      Bottom = new
      Front = new
      Back = new
      Left = new
      Right = new
    end

    sig { returns(Face) }
    def -@
      case self
      when Top then Bottom
      when Bottom then Top
      when Front then Back
      when Back then Front
      when Left then Right
      when Right then Left
      end
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @cubes = T.let(Set.new, T::Set[Cube])
    @input.lines(chomp: true).each do |line|
      x, y, z = line.split(',')
      @cubes << [x.to_i, y.to_i, z.to_i]
    end
    @x_range = T.let(Range.new(*@cubes.map { _1[0] }.minmax), T::Range[Integer])
    @y_range = T.let(Range.new(*@cubes.map { _1[1] }.minmax), T::Range[Integer])
    @z_range = T.let(Range.new(*@cubes.map { _1[2] }.minmax), T::Range[Integer])
  end

  sig { params(cube: Cube).returns(T::Boolean) }
  def cube?(cube)
    @cubes.include?(cube)
  end

  sig { params(cube: Cube, face: Face).returns(T::Boolean) }
  def free_face?(cube, face)
    cube?(cube) && !cube?(neighbor(cube, face))
  end

  sig { params(cube: Cube, face: Face).returns(Cube) }
  def neighbor(cube, face)
    x, y, z = cube
    case face
    when Face::Top then [x, y, z + 1]
    when Face::Bottom then [x, y, z - 1]
    when Face::Right then [x + 1, y, z]
    when Face::Left then [x - 1, y, z]
    when Face::Front then [x, y - 1, z]
    when Face::Back then [x, y + 1, z]
    end
  end

  sig { params(cube: Cube, face: Face).returns(T::Array[[Cube, Face]]) }
  def face_neighbors(cube, face)
    res = []
    Face.each_value do |dir|
      next if dir == face
      next if dir == -face

      # adjacent cubes, same face
      n = neighbor(cube, dir)
      res << [n, face] if free_face?(n, dir)

      n2 = neighbor(neighbor(cube, face), dir)
      # another face of the empty space we're facing
      res << [n2, -dir] if free_face?(n2, -dir) && cube?(n2)

      # an adjacent face of the same cube
      res << [cube, dir] if free_face?(cube, dir) && !cube?(n2)
    end
    res
  end

  sig { returns(Integer) }
  def part1
    @cubes.sum do |c|
      Face.each_value.count { |f| free_face?(c, f) }
    end
  end

  sig { params(cube: Cube).returns(T::Boolean) }
  def within_bounds?(cube)
    @x_range.include?(cube[0]) && @y_range.include?(cube[1]) && @z_range.include?(cube[2])
  end

  sig { params(cube: Cube).returns(T.any(FalseClass, T::Set[Cube])) }
  def interior?(cube)
    q = T.let([cube], T::Array[Cube])
    v = q.to_set

    while (c = q.shift)
      Face.each_value do |f|
        n = neighbor(c, f)
        next if cube?(n)
        next if v.include?(n)
        return false unless within_bounds?(n)

        v << n
        q << n
      end
    end

    v
  end

  sig { returns(Integer) }
  def part2
    @x_range.each do |x|
      @y_range.each do |y|
        @z_range.each do |z|
          c = [x, y, z]
          next if cube?(c)

          r = interior?(c)
          next unless r

          @cubes.merge(r)
        end
      end
    end

    part1
  end
end
