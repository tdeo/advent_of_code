# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class MonkeyMap
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    map, path = input.split("\n\n")
    map = T.must(map).split("\n")
    @height = T.let(map.size, Integer)
    @width = T.let(map.map(&:size).max.to_i, Integer)
    @map = T.let(map.map { _1.ljust(@width, ' ').chars }, T::Array[T::Array[String]])
    @path = T.let(T.must(path).strip.scan(/\d+|\D+/).map(&:to_s), T::Array[String])
  end

  Coords = T.type_alias { [Integer, Integer] }

  sig { params(i: Integer, j: Integer).returns(T.nilable(String)) }
  def at(i, j)
    @map.fetch(i).fetch(j)
  end

  sig { params(coords: Coords, dir: String).returns(T.nilable(Coords)) }
  def neighbor(coords, dir)
    di, dj = case dir
             when 'R' then [0, 1]
             when 'L' then [0, -1]
             when 'D' then [1, 0]
             when 'U' then [-1, 0]
             else raise
             end

    i, j = coords
    loop do
      i = (i + di) % @height
      j = (j + dj) % @width
      break if at(i, j) != ' '
    end
    at(i, j) == '.' ? [i, j] : nil
  end

  sig { returns(Coords) }
  def start_pos
    j = @map.fetch(0).each_with_index.find { |c, _j| c != ' ' }
    [0, T.must(j)[1]]
  end

  sig { params(dir: String, turn: String).returns(String) }
  def next_dir(dir, turn)
    case turn
    when 'R' then dir.tr('RDLU', 'DLUR')
    when 'L' then dir.tr('RDLU', 'URDL')
    else raise
    end
  end

  sig { returns(Integer) }
  def part1
    current = start_pos
    direction = 'R'
    @path.each do |instruction|
      case instruction
      when /\d+/
        instruction.to_i.times do
          next_pos = neighbor(current, direction)
          break if next_pos.nil?

          current = next_pos
        end
      else
        direction = next_dir(direction, instruction)
      end
    end

    res = case direction
          when 'R' then 0
          when 'D' then 1
          when 'L' then 2
          when 'U' then 3
          else raise
          end
    res + ((current[0] + 1) * 1000) + ((current[1] + 1) * 4)
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
