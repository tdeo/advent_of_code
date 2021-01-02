# frozen_string_literal: true

class Security
  def initialize(input)
    @rooms = []
    input.strip.each_line do |l|
      m = /^([-a-z]+)-(\d+)\[([a-z]+)\]$/.match(l.strip)
      @rooms << {
        name: m[1],
        sector_id: m[2].to_i,
        checksum: m[3],
      }
    end
  end

  def valid?(room)
    chars = room[:name].tr('-', '').chars
    top_chars = chars.group_by { |c| c }.map { |k, v| [k, v.size] }.sort_by { |c, count| [-count, c] }.map(&:first)
    top_chars.first(5).join == room[:checksum]
  end

  def rotate(letter, times)
    return letter if letter == '-'

    ((letter.ord - 'a'.ord + times) % 26 + 'a'.ord).chr
  end

  def decrypted_name(room)
    room[:name].chars.map { |c| rotate(c, room[:sector_id]) }.join
  end

  def valid_rooms
    @rooms.select { |r| valid?(r) }
  end

  def part1
    valid_rooms.sum { |r| r[:sector_id] }
  end

  def part2
    valid_rooms.find do |r|
      n = decrypted_name(r)
      n.include?('north') && n.include?('pole')
    end[:sector_id]
  end
end
