# frozen_string_literal: true

class SeatingSystem
  OCCUPIED = '#'
  EMPTY = 'L'
  DIRS = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1],
  ].freeze

  def initialize(input)
    @input = input
    @maze = @input.each_line.map(&:strip)
    @height = @maze.size
    @width = @maze.first.size
  end

  def neighbours(i, j)
    @neighbours ||= {}
    @neighbours[i] ||= Hash.new { |h, k| h[k] = [] }
    return @neighbours[i][j] if @neighbours[i].key?(j)

    DIRS.each do |di, dj|
      ii = i + di
      jj = j + dj
      next unless ii >= 0 && jj >= 0 && ii < @height && jj < @width

      @neighbours[i][j] << [ii, jj]
    end
    @neighbours[i][j]
  end

  def visible_from(i, j)
    @visible_from ||= {}
    @visible_from[i] ||= Hash.new { |h, k| h[k] = [] }
    return @visible_from[i][j] if @visible_from[i].key?(j)

    DIRS.each do |di, dj|
      ii = i + di
      jj = j + dj

      loop do
        break if ii < 0 || jj < 0 || ii >= @height || jj >= @width

        if [OCCUPIED, EMPTY].include?(@maze[ii][jj])
          @visible_from[i][j] << [ii, jj]
          break
        end

        ii += di
        jj += dj
      end
    end

    @visible_from[i][j]
  end

  def step!(neighbours:, visible_limit:)
    changed = false
    succ = @maze.map(&:dup)
    @maze.each_with_index do |line, i|
      line.each_char.with_index do |char, j|
        n = send(neighbours, i, j)
        occupied = n.count { |ii, jj| @maze[ii][jj] == OCCUPIED }
        if char == EMPTY && occupied == 0
          succ[i][j] = OCCUPIED
          changed = true
        elsif char == OCCUPIED && occupied >= visible_limit
          succ[i][j] = EMPTY
          changed = true
        end
      end
    end
    @maze = succ
    changed
  end

  def print!
    @maze.each { puts _1 }
    puts ''
  end

  def occupied
    @maze.sum { |line| line.count(OCCUPIED) }
  end

  def part1
    loop { break unless step!(neighbours: :neighbours, visible_limit: 4) }
    occupied
  end

  def part2
    loop { break unless step!(neighbours: :visible_from, visible_limit: 5) }
    occupied
  end
end
