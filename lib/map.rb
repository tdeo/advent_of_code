# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

class Map
  extend T::Sig
  extend T::Generic

  Elem = type_member
  Coords = T.type_alias { [Integer, Integer] }

  class Cell
    include Comparable
    extend T::Sig
    extend T::Generic

    Elem = type_member

    sig { returns(Elem) }
    attr_accessor :value

    sig { params(map: Map[Elem], i: Integer, j: Integer).void }
    def initialize(map:, i:, j:)
      @i = i
      @j = j
      @map = map
      @value = T.let(T.must(@map.value_at(i, j)), Elem)
    end

    sig { params(other: Cell[Elem]).returns(Integer) }
    def <=>(other)
      coords <=> other.coords
    end

    sig { returns(Coords) }
    def coords
      [@i, @j]
    end

    sig { returns(T.nilable(Cell[Elem])) }
    def above
      @map.at(@i - 1, @j)
    end

    sig { returns(T.nilable(Cell[Elem])) }
    def below
      @map.at(@i + 1, @j)
    end

    sig { returns(T.nilable(Cell[Elem])) }
    def left
      @map.at(@i, @j - 1)
    end

    sig { returns(T.nilable(Cell[Elem])) }
    def right
      @map.at(@i, @j + 1)
    end

    sig { returns(T::Array[Cell[Elem]]) }
    def neighbours
      [above, below, left, right].compact
    end
  end

  sig { params(input: String, blk: T.proc.params(arg0: String).returns(Elem)).void }
  def initialize(input, &blk)
    @raw_input = input
    @grid = T.let(
      input.each_line(chomp: true).map do |line|
        line.chars.map(&blk)
      end,
      T::Array[T::Array[Elem]],
    )
    @height = T.let(@grid.size, Integer)
    @width = T.let(T.must(@grid[0]).size, Integer)
  end

  sig { params(i: Integer, j: Integer).returns(T.nilable(Cell[Elem])) }
  def at(i, j)
    return nil if i < 0 || j < 0 || i >= @height || j >= @width

    Cell.new(map: self, i: i, j: j)
  end

  sig { params(i: Integer, j: Integer).returns(T.nilable(Elem)) }
  def value_at(i, j)
    return nil if i < 0 || j < 0

    @grid.dig(i, j)
  end

  sig { params(i: Integer, j: Integer, val: Elem).void }
  def set(i, j, val)
    T.must(@grid[i])[j] = val
  end

  sig { returns(T::Enumerator[Cell[Elem]]) }
  def cells
    Enumerator.new do |y|
      (0...@height).each do |i|
        (0...@width).each do |j|
          y << at(i, j)
        end
      end
    end
  end

  sig do
    params(_blk: T.proc.params(arg0: Elem, i: T.nilable(Integer), j: T.nilable(Integer)).returns(T::Boolean))
      .returns(T.nilable(Cell[Elem]))
  end
  def find(&_blk)
    (0...@height).each do |i|
      (0...@width).each do |j|
        val = value_at(i, j)
        return Cell.new(map: self, i: i, j: j) if yield T.cast(val, Elem), i, j
      end
    end
    nil
  end
end
