# frozen_string_literal: true

class Elves
  def initialize(input)
    @input = input.strip
  end

  def say!
    @input.gsub!('333', 'cc')
    @input.gsub!('222', 'cb')
    @input.gsub!('111', 'ca')
    @input.gsub!('33', 'bc')
    @input.gsub!('22', 'bb')
    @input.gsub!('11', 'ba')
    @input.gsub!('3', 'ac')
    @input.gsub!('2', 'ab')
    @input.gsub!('1', 'aa')
    @input.tr!('abc', '123')
  end

  def part1(n = 40)
    n.times { say! }
    @input.size
  end

  def part2
    part1(50)
  end
end
