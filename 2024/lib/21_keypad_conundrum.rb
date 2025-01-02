# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class KeypadConundrum
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @codes = T.let(input.lines(chomp: true), T::Array[String])
  end

  sig { params(char: String).returns(Integer) }
  def row(char)
    case char
    when '7', '8', '9' then 0
    when '4', '5', '6' then 1
    when '1', '2', '3' then 2
    when '0', 'A', '^', ' ' then 3
    when '<', 'v', '>' then 4
    else raise
    end
  end

  sig { params(char: String).returns(Integer) }
  def col(char)
    case char
    when '7', '4', '1', '<', ' ' then 0
    when '8', '5', '2', '0', '^', 'v' then 1
    when '9', '6', '3', 'A', '>' then 2
    else raise
    end
  end

  sig { params(from: String, to: String).returns(String) }
  def shortest_path(from, to)
    dcol = col(to) - col(from)
    drow = row(to) - row(from)
    moves = ''
    moves += '<' * -dcol if dcol < 0
    moves += 'v' * drow if drow > 0
    moves += '^' * -drow if drow < 0
    moves += '>' * dcol if dcol > 0

    moves.reverse! if (col(to) == col(' ') && row(from) == row(' ')) || (col(from) == col(' ') && row(to) == row(' '))
    moves += 'A'
    moves
  end

  sig { params(robots: Integer).returns(Integer) }
  def part1(robots = 3)
    @codes.sum { _1.to_i * shortest_dist(_1, robots) }
  end

  sig { params(code: String, robots: Integer).returns(Integer) }
  def shortest_dist(code, robots)
    return code.size if robots == 0

    @shortest_dist ||= T.let({}, T.nilable(T::Hash[[String, Integer], Integer]))
    @shortest_dist[[code, robots]] ||= code.each_char.with_index.sum do |c, i|
      previous = 'A'
      previous = T.must(code[i - 1]) if i > 0

      shortest_dist(shortest_path(previous, c), robots - 1)
    end
  end

  sig { returns(Integer) }
  def part2
    part1(26)
  end
end
