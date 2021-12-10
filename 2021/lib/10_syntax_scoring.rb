# frozen_string_literal: true

class SyntaxScoring
  def initialize(input)
    @input = input
    @lines = input.split("\n")
  end

  def invalid_char(line)
    q = []
    line.each_char do |c|
      case c
      when '(', '[', '{', '<'
        q << c
      when ')', ']', '}', '>'
        return c unless q[-1] == c.tr(')]}>', '([{<')

        q.pop
      else
        raise "Invalid char #{c}"
      end
    end
    nil
  end

  def score(char)
    case char
    when ')' then 3
    when ']' then 57
    when '}' then 1197
    when '>' then 25_137
    when nil then 0
    end
  end

  def part1
    @lines.sum do |line|
      inv = invalid_char(line)
      score(inv)
    end
  end

  def line_remainder(line)
    q = []
    line.each_char do |c|
      case c
      when '(', '[', '{', '<'
        q << c
      when ')', ']', '}', '>'
        raise unless q[-1] == c.tr(')]}>', '([{<')

        q.pop
      else
        raise "Invalid char #{c}"
      end
    end
    q
  end

  def part2
    scores = []
    @lines.each do |line|
      next unless invalid_char(line).nil?

      rem = line_remainder(line)
      s = 0
      rem.reverse_each do |c|
        s *= 5
        s += case c
             when '(' then 1
             when '[' then 2
             when '{' then 3
             when '<' then 4
             end
      end
      scores << s
    end
    scores.sort!
    scores[scores.size / 2]
  end
end
