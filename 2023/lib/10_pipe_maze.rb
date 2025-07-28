# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class PipeMaze
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @grid = T.let(@input.lines(chomp: true).map(&:chars), T::Array[T::Array[String]])
  end

  sig { params(i: Integer, j: Integer).returns(T.nilable(String)) }
  def at(i, j)
    @grid.fetch(i, []).fetch(j, nil)
  end

  sig { params(i: Integer, j: Integer).returns(T::Boolean) }
  def connects_left?(i, j)
    ['-', '7', 'J'].include?(at(i, j))
  end
  sig { params(i: Integer, j: Integer).returns(T::Boolean) }
  def connects_right?(i, j)
    ['-', 'F', 'L'].include?(at(i, j))
  end
  sig { params(i: Integer, j: Integer).returns(T::Boolean) }
  def connects_top?(i, j)
    ['|', 'J', 'L'].include?(at(i, j))
  end
  sig { params(i: Integer, j: Integer).returns(T::Boolean) }
  def connects_bottom?(i, j)
    ['|', '7', 'F'].include?(at(i, j))
  end
  sig { params(i: Integer, j: Integer).returns(T::Array[[Integer, Integer]]) }
  def neighbours(i, j)
    res = T.let([], T::Array[[Integer, Integer]])
    res << [i + 1, j] if connects_bottom?(i, j)
    res << [i - 1, j] if connects_top?(i, j)
    res << [i, j + 1] if connects_right?(i, j)
    res << [i, j - 1] if connects_left?(i, j)
    res
  end

  sig { returns([Integer, Integer]) }
  def find_start
    @grid.each_with_index.find do |row, i|
      row.each_with_index.find do |c, j|
        return [i, j] if c == 'S'
      end
    end
    [0, 0]
  end

  sig { returns(T::Hash[[Integer, Integer], Integer]) }
  def the_loop
    start = find_start
    viewed = T.let({ start => 0 }, T::Hash[[Integer, Integer], Integer])
    queue = T.let([], T::Array[[Integer, Integer]])
    i, j = start
    queue << [i - 1, j] if connects_bottom?(i - 1, j)
    queue << [i, j - 1] if connects_right?(i, j - 1)
    queue << [i + 1, j] if connects_top?(i + 1, j)
    queue << [i, j + 1] if connects_left?(i, j + 1)
    queue.each { viewed[_1] = 1 }

    until queue.empty?
      q = T.must(queue.shift)
      neighbours(*q).each do |n|
        next if viewed[n]

        viewed[n] = T.must(viewed[q]) + 1
        queue << n
      end
    end
    viewed
  end

  sig { returns(Integer) }
  def part1
    the_loop.values.max || 0
  end

  sig { returns(Integer) }
  def part2
    i, j = find_start
    start_chars = %w[| - F J L 7]
    start_chars &= %w[| F 7] if connects_top?(i + 1, j)
    start_chars &= %w[| J L] if connects_bottom?(i - 1, j)
    start_chars &= %w[- J 7] if connects_right?(i, j - 1)
    start_chars &= %w[- F L] if connects_left?(i, j + 1)
    start_char = T.must(start_chars.first)
    mem = the_loop
    @grid.each_with_index.sum do |row, ii|
      res = row.each_with_index.map do |char, jj|
        mem.key?([ii, jj]) ? char : '.'
      end.join
      res.tr('S', start_char)
         .tr('-', '')
         .gsub(/LJ|F7/, '')
         .gsub(/L7|FJ/, '|')
         .gsub(/\|\.*\|/) { 'X' * (_1.size - 2) }
         .gsub(/[^X]/, '')
         .size
    end
  end
end
