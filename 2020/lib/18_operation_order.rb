class OperationOrder
  def initialize(input)
    @input = input
  end

  def calculate(input)
    r = input.match(/\(([^\(\)]*)\)/)
    if r
      return calculate("#{r.pre_match} #{calculate(r[1])} #{r.post_match}")
    end

    if input =~ /[\+\*]/
      r = input.match(/(\d+)\s*(\+|\*)\s*(\d+)/)

      if r[2] == '*'
        return calculate("#{r[1].to_i * r[3].to_i} #{r.post_match}")
      elsif r[2] == '+'
        return calculate("#{r[1].to_i + r[3].to_i} #{r.post_match}")
      else
        fail
      end
    end

    input.to_i
  end

  def part1
    @input.each_line.sum { |line| calculate(line) }
  end

  def calculate2(input)
    r = input.match(/\(([^\(\)]*)\)/)
    if r
      return calculate2("#{r.pre_match} #{calculate2(r[1])} #{r.post_match}")
    end

    if input =~ /\+/
      r = input.match(/(\d+)\s*\+\s*(\d+)/)

      return calculate2("#{r.pre_match} #{r[1].to_i + r[2].to_i} #{r.post_match}")
    end

    eval(input)
  end

  def part2
    @input.each_line.sum { |line| calculate2(line) }
  end
end
