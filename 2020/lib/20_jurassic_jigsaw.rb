require 'set'

class JurassicJigsaw
  ORIENTATIONS = (0...8).to_a

  MONSTER = [
    '                  # ',
    '#    ##    ##    ###',
    ' #  #  #  #  #  #   ',
  ]

  class Tile
    attr_reader :id
    attr_accessor :orientation

    def initialize(input)
      @id = input.split("\n")[0].match(/\d+/)[0].to_i
      @original = input.split("\n")[1..-1]
      @orientation = 0
      # 0-3 : rotations clockwise
      # 4-7: same starting with vertical symmetry
    end

    def view
      @view = nil if @view_orientation != @orientation
      @view_orientation = @orientation
      return @view if @view

      lines = if @orientation >= 4
        @original.map(&:reverse)
      else
        @original.map(&:dup)
      end

      # rotate 90 deg clockwise
      if orientation % 2 == 1
        lines = (0...lines.size).map do |i|
          (0...lines.size).map do |j|
            lines[lines.size - j - 1][i]
          end.join('')
        end
      end

      # Rotate 180deg
      if (orientation % 4) > 1
        lines = lines.reverse.map(&:reverse)
      end

      @view = lines
    end

    def border(side)
      case side
      when :top
        view[0]
      when :left
        view.map { _1[0] }.join
      when :bottom
        view[-1]
      when :right
        view.map { _1[-1] }.join
      end
    end
  end

  def initialize(input)
    @input = input
    @borders = Hash.new { |hash, key| hash[key] = Set.new }

    @tiles = {}

    @input.split("\n\n").each do |tile_input|
      tile = Tile.new(tile_input)
      @tiles[tile.id] = tile

      ORIENTATIONS.each do |orientation|
        tile.orientation = orientation
        %i[top left bottom right].each do |side|
          @borders[tile.border(side)] << tile.id
        end
      end
    end

    compute_fits
  end

  def compute_fits
    @fits = Hash.new { |hash, key| hash[key] = Set.new }

    @borders.each_value do |val|
      val.to_a.permutation(2) do |a, b|
        @fits[a] << b if b != a
      end
    end
  end

  def part1
    corners = @fits.select { |k, v| v.size == 2 }.map(&:first)
    fail "Found #{corners.size} corners" unless corners.size == 4

    corners.reduce(1, :*)
  end

  def build_map
    return @map unless @map.nil?

    map = []

    used = {}
    corner_id = @fits.find { |k, v| v.size == 2 }.first
    corner = @tiles[corner_id]
    ORIENTATIONS.find do |orientation|
      corner.orientation = orientation
      @borders[corner.border(:right)].any? { _1 != corner.id } &&
        @borders[corner.border(:bottom)].any? { _1 != corner.id }
    end

    map << [corner]
    used[corner.id] = true

    while true do
      while true do
        prev = map[-1][-1]
        tile_id = @borders[prev.border(:right)].find { !used.key? _1 }
        break if tile_id.nil?

        tile = @tiles[tile_id]
        ORIENTATIONS.find do |orientation|
          tile.orientation = orientation
          tile.border(:left) == prev.border(:right)
        end
        map[-1] << tile
        used[tile.id] = true
      end

      prev = map[-1][0]
      tile_id = @borders[prev.border(:bottom)].find { !used.key? _1 }
      break if tile_id.nil?

      tile = @tiles[tile_id]
      ORIENTATIONS.find do |orientation|
        tile.orientation = orientation
        tile.border(:top) == prev.border(:bottom)
      end
      map << [tile]
      used[tile.id] = true
    end

    @map = map
  end

  def count_monsterless(tile)
    monster_pos = []
    MONSTER.each_with_index do |row, i|
      row.each_char.each_with_index do |char, j|
        monster_pos << [i, j] if char == ?#
      end
    end

    habitat_used = {}
    (0...tile.view.size - MONSTER.size).each do |i|
      row = tile.view[i]
      (0...row.size - MONSTER[0].size).each do |j|
        next unless monster_pos.all? { |ii, jj| tile.view[i+ii][j+jj] == ?# }

        monster_pos.each do |ii, jj|
          habitat_used[[i + ii, j + jj]] = true
        end
      end
    end

    r = 0
    tile.view.each_with_index do |row, i|
      row.each_char.each_with_index do |char, j|
        next unless char == ?#
        next if habitat_used.key?([i, j])

        r += 1
      end
    end

    r
  end

  def part2
    build_map

    tile_size = @tiles.values.first.view.size
    map_entry = []
    map_entry << "Map 0"
    @map.each do |row|
      (1...tile_size - 1).each do |i|
        map_entry << row.map { _1.view[i][1..-2] }.join
      end
    end

    map = Tile.new(map_entry.join("\n"))

    ORIENTATIONS.map do |orientation|
      map.orientation = orientation
      count_monsterless(map)
    end.min
  end
end
