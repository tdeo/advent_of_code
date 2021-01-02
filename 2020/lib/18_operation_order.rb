# frozen_string_literal: true

class OperationOrder
  def initialize(input)
    @input = input
  end

  def calculate(input)
    r = input.match(/\(([^()]*)\)/)
    return calculate("#{r.pre_match} #{calculate(r[1])} #{r.post_match}") if r

    if /[+*]/.match?(input)
      r = input.match(/(\d+)\s*(\+|\*)\s*(\d+)/)

      return calculate("#{r[1].to_i * r[3].to_i} #{r.post_match}") if r[2] == '*'
      return calculate("#{r[1].to_i + r[3].to_i} #{r.post_match}") if r[2] == '+'

      raise
    end

    input.to_i
  end

  def part1
    @input.each_line.sum { |line| calculate(line) }
  end

  def calculate2(input)
    r = input.match(/\(([^()]*)\)/)
    return calculate2("#{r.pre_match} #{calculate2(r[1])} #{r.post_match}") if r

    if input.include?('+')
      r = input.match(/(\d+)\s*\+\s*(\d+)/)

      return calculate2("#{r.pre_match} #{r[1].to_i + r[2].to_i} #{r.post_match}")
    end

    eval(input) # rubocop:disable Security/Eval
  end

  def part2
    @input.each_line.sum { |line| calculate2(line) }
  end
end
