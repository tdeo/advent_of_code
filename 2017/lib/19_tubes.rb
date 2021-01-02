# frozen_string_literal: true

class Tubes
  def initialize(input)
    @grid = input.split("\n").map(&:chars)
    @pos = find_entry
    @dir = [1, 0] # Increasing row by 1
    @letters = []
  end

  def find_entry
    [0, @grid[0].index('|')]
  end

  def dirs
    [ # iterating with left turns
      [1, 0], # Down
      [0, 1], # Right
      [-1, 0], # Up
      [0, -1], # Left
    ]
  end

  def valid_cell?(i, j)
    i >= 0 && i < @grid.size && j >= 0 && j < @grid[i].size
  end

  def cell(i, j)
    [@grid[i][j], i, j]
  end

  def turn_left_cell
    new_dir = dirs[(dirs.index(@dir) + 1) % dirs.size]
    coords = [@pos[0] + new_dir[0], @pos[1] + new_dir[1]]
    valid_cell?(*coords) ? cell(*coords) : nil
  end

  def turn_right_cell
    new_dir = dirs[(dirs.index(@dir) - 1) % dirs.size]
    coords = [@pos[0] + new_dir[0], @pos[1] + new_dir[1]]
    valid_cell?(*coords) ? cell(*coords) : nil
  end

  def straight_cell
    coords = [@pos[0] + @dir[0], @pos[1] + @dir[1]]
    valid_cell?(*coords) ? cell(*coords) : nil
  end

  def move!
    if straight_cell && straight_cell[0] != ' '
      @pos = [straight_cell[1], straight_cell[2]]
    elsif turn_left_cell && turn_left_cell[0] != ' '
      @pos = [turn_left_cell[1], turn_left_cell[2]]
      @dir = dirs[(dirs.index(@dir) + 1) % dirs.size]
    elsif turn_right_cell && turn_right_cell[0] != ' '
      @pos = [turn_right_cell[1], turn_right_cell[2]]
      @dir = dirs[(dirs.index(@dir) - 1) % dirs.size]
    else
      return 'end'
    end
    @letters << cell(*@pos)[0] if /^[A-Z]$/.match?(cell(*@pos)[0])
  end

  def part1
    loop { break if move! == 'end' }
    @letters.join
  end

  def part2
    i = 0
    loop do
      i += 1
      break if move! == 'end'
    end
    i
  end
end
