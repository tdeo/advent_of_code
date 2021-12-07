# frozen_string_literal: true

class GiantSquid
  def initialize(input)
    @input = input.split("\n").reject(&:empty?)
    @draws = @input.shift.split(',').map(&:to_i)

    @grids = @input.each_slice(5).map do |grid|
      grid.map { _1.split.map(&:to_i) }
    end
  end

  def winning_boards
    @grids.select do |grid|
      wins = false
      (0...5).each do |i|
        wins ||= true if (0...5).all? { |j| grid[i][j].nil? }
        wins ||= true if (0...5).all? { |j| grid[j][i].nil? }
      end

      wins
    end
  end

  def draw!
    @drawn ||= []
    @drawn << @draws.shift

    @grids.each do |grid|
      grid.each do |row|
        (0...5).each do |i|
          row[i] = nil if row[i] == @drawn.last
        end
      end
    end
  end

  def score(board)
    board.sum { |row| row.reject(&:nil?).sum }
  end

  def part1
    until @draws.empty?
      draw!

      winning = winning_boards.first
      next if winning.nil?

      return score(winning) * @drawn[-1]
    end
  end

  def part2
    prev_boards = nil
    while winning_boards.size < @grids.size
      prev_boards = winning_boards
      draw!
    end
    last_board = (winning_boards - prev_boards).first
    score(last_board) * @drawn[-1]
  end
end
