# frozen_string_literal: true

class FirewallRules
  def initialize(input)
    @rules = input.split("\n").map { |r| r.split('-').map(&:to_i) }
    @valids = [[0, (2**32) - 1]]
  end

  def apply_rule!(rule)
    new_valid = []
    @valids.each do |valid|
      new_valid += [
        [valid[0], [rule[0] - 1, valid[1]].min],
        [[rule[1] + 1, valid[0]].max, valid[1]],
      ].select { |i| i[0] <= i[1] }
    end
    @valids = new_valid
  end

  def part1
    @rules.each { |r| apply_rule!(r) }
    @valids.sort!
    @valids.first.first
  end

  def part2
    @rules.each { |r| apply_rule!(r) }
    @valids.sum { |e| e[1] - e[0] + 1 }
  end
end
