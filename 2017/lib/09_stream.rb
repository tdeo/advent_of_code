# frozen_string_literal: true

class Stream
  def initialize(input)
    @input = input
    @input = @input.gsub(/([^!]|^)!./, '\1') while @input =~ /([^!]|^)!./
  end

  def part1
    @input = @input.gsub(/<[^>]+>/, '') while @input =~ /<[^>]+>/
    level = 0
    sum = 0
    @input.each_char do |c|
      if c == '{'
        level += 1
        sum += level
      end
      level -= 1 if c == '}'
    end
    sum
  end

  def part2
    c = 0
    @input.gsub(/<([^>]+)>/) { |m| c += m.size - 2 }
    c
  end
end
