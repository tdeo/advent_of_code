# frozen_string_literal: true

class SevenSegmentSearch
  def initialize(input)
    @input = input
    @cases = input.lines.map do |line|
      inputs, outputs = line.split(' | ')
      {
        inputs: inputs.split,
        outputs: outputs.split,
      }
    end
  end

  def part1
    @cases.sum do |row|
      row[:outputs].count { _1.length < 5 || _1.length == 7 }
    end
  end

  def compute_segments(inputs)
    vals = {}
    vals[1] = inputs.find { _1.length == 2 }
    vals[4] = inputs.find { _1.length == 4 }
    vals[7] = inputs.find { _1.length == 3 }
    vals[8] = inputs.find { _1.length == 7 }
    inputs.delete vals[1]
    inputs.delete vals[4]
    inputs.delete vals[7]
    inputs.delete vals[8]
    # left : 0,2,3,5,6,9
    segments = {}
    segments[:top] = vals[7].chars - vals[1].chars
    poss_0_3_9 = inputs.select { vals[1].chars & _1.chars == vals[1].chars }
    poss_0_3_9.each { inputs.delete _1 }
    # left: 2,5,6
    vals[3] = poss_0_3_9.find { _1.length == 5 }
    vals[9] = poss_0_3_9.find { vals[4].chars & _1.chars == vals[4].chars }
    poss_0_3_9.delete vals[3]
    poss_0_3_9.delete vals[9]
    vals[0] = poss_0_3_9.first

    vals[6] = inputs.find { _1.length == 6 }
    inputs.delete(vals[6])
    # left: 2, 5
    vals[5] = inputs.find { _1.chars & vals[9].chars == _1.chars }
    inputs.delete vals[5]
    vals[2] = inputs.first

    vals
  end

  def part2
    sum = 0
    @cases.each do |row|
      mapping = compute_segments(row[:inputs])
      output = row[:outputs].map do |out|
        entry = mapping.find { |_, v| v.chars.sort == out.chars.sort }
        entry.first
      end
      sum += output.join.to_i
    end
    sum
  end
end
