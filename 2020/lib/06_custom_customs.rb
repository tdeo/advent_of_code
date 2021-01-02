# frozen_string_literal: true

class CustomCustoms
  def initialize(input)
    @input = input
    @groups = @input.split("\n\n").map do |group|
      group.each_line.map { _1.chomp.chars }
    end
  end

  def count(group)
    r = {}
    group.each do |person|
      person.each { r[_1] = true}
    end
    r.count { |_, v| v }
  end

  def part1
    @groups.map { count _1 }.sum
  end

  def count2(group)
    r = Hash.new(0)
    group.each do |person|
      person.each { r[_1] += 1}
    end
    r.count { |_, v| v == group.size }
  end

  def part2
    @groups.map { count2 _1 }.sum
  end
end
