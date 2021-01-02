# frozen_string_literal: true

class ReportRepair
  def initialize(input)
    @input = input
    @values = input.each_line.map(&:to_i)
    @values_hash = {}
    @values.each do |val|
      @values_hash[val] = true
    end
  end

  def part1
    target = 2020
    @values.each do |val|
      return val * (target - val) if @values_hash.key?(target - val)
    end
  end

  def part2
    target = 2020
    @values.each_with_index do |v1, i|
      @values[0...i].each do |v2|
        return v1 * v2 * (target - v1 - v2) if @values_hash.key?(target - v1 - v2)
      end
    end
  end
end
