# frozen_string_literal: true

class PacketDecoder
  def initialize(input)
    @input = input
    @total_versions = 0
  end

  def parse_packet(chars)
    version = chars.shift(3).join.to_i(2)
    @total_versions += version
    type_id = chars.shift(3).join.to_i(2)

    if type_id == 4
      value = ''
      loop do
        bits = chars.shift(5)
        value += bits[1..].join
        break if bits[0] == '0'
      end
      value.to_i(2)
    else
      length_type_id = chars.shift
      subpackets = []
      case length_type_id
      when '0'
        subpackets_size = chars.shift(15).join.to_i(2)
        current_size = chars.size
        subpackets << parse_packet(chars) while chars.size > current_size - subpackets_size
      when '1'
        subpackets_count = chars.shift(11).join.to_i(2)
        subpackets_count.times do
          subpackets << parse_packet(chars)
        end
      end

      case type_id
      when 0 then subpackets.sum
      when 1 then subpackets.reduce(:*)
      when 2 then subpackets.min
      when 3 then subpackets.max
      when 5 then subpackets[0] > subpackets[1] ? 1 : 0
      when 6 then subpackets[0] < subpackets[1] ? 1 : 0
      when 7 then subpackets[0] == subpackets[1] ? 1 : 0
      end
    end
  end

  def to_bits(hex)
    res = []
    hex.each_char do |c|
      res += c.to_i(16).to_s(2).rjust(4, '0').chars
    end
    res
  end

  def part1
    parse_packet(to_bits(@input))
    @total_versions
  end

  def part2
    parse_packet(to_bits(@input))
  end
end
