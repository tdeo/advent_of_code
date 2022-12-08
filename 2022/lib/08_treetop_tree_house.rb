# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class TreetopTreeHouse
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @trees = @input.split("\n").map do |line|
      line.chars.map(&:to_i)
    end
  end

  sig { params(i: Integer, j: Integer).returns(T::Boolean) }
  def visible?(i, j)
    # left
    return true if (0...j).all? do |jj|
      @trees[i][jj] < @trees[i][j]
    end

    # right
    return true if (j + 1...@trees[i].size).all? do |jj|
      @trees[i][jj] < @trees[i][j]
    end

    # top
    return true if (0...i).all? do |ii|
      @trees[ii][j] < @trees[i][j]
    end

    # bottom
    return true if (i + 1...@trees.size).all? do |ii|
      @trees[ii][j] < @trees[i][j]
    end

    false
  end

  sig { returns(Integer) }
  def part1
    (0...@trees.size).sum do |i|
      (0...@trees[i].size).count do |j|
        visible?(i, j)
      end
    end
  end

  def scenic_distance(i, j)
    res = [0, 0, 0, 0]

    # up
    (0...i).reverse_each do |ii|
      res[2] += 1
      break if @trees[ii][j] >= @trees[i][j]
    end

    # left
    (0...j).reverse_each do |jj|
      res[3] += 1
      break if @trees[i][jj] >= @trees[i][j]
    end

    # down
    (i + 1...@trees.size).each do |ii|
      res[0] += 1
      break if @trees[ii][j] >= @trees[i][j]
    end

    # right
    (j + 1...@trees[i].size).each do |jj|
      res[1] += 1
      break if @trees[i][jj] >= @trees[i][j]
    end

    res.compact.reduce(1, :*)
  end

  sig { returns(Integer) }
  def part2
    (0...@trees.size).map do |i|
      (0...@trees[i].size).map do |j|
        scenic_distance(i, j)
      end.max
    end.max
  end
end
