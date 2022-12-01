# frozen_string_literal: true

class Explosives
  def initialize(input)
    @input = input.strip
  end

  def part1
    decoded = ''
    until @input.empty?
      if /^\((?<a>\d+)x(?<b>\d+)\)/ =~ @input
        @input.sub!(/^\((?<a>\d+)x(?<b>\d+)\)/, '')
        part = @input.slice!(0, a.to_i) * b.to_i
        decoded += part
      else
        decoded += @input.slice!(0)
      end
    end
    decoded.size
  end

  def decode_length(string)
    return 0 if string.empty?
    return 1 + decode_length(string[1..]) unless /^\((?<a>\d+)x(?<b>\d+)\)/ =~ string

    bis = string.sub(/^\((?<a>\d+)x(?<b>\d+)\)/, '')
    (b.to_i * decode_length(bis[0...a.to_i])) + decode_length(bis[a.to_i..])
  end

  def part2
    decode_length(@input)
  end
end
