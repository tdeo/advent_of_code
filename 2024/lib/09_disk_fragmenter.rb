# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class DiskFragmenter
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @disk = T.let(@input.chars.each_slice(2).with_index.flat_map do |(a, b), i|
      [
        [a.to_i, i],
        [b.to_i, nil],
      ]
    end, T::Array[[Integer, T.nilable(Integer)]],)
  end

  sig { void }
  def fill!
    i = 0
    @disk.pop while @disk.last&.last == -1

    loop do
      @disk.pop while @disk.last&.last.nil? || @disk.last&.first == 0

      block = @disk[i]
      q = @disk.last
      break if block.nil? || q.nil?
      next i += 1 unless block[1].nil?

      if q[0] < block[0]
        @disk.insert(i, [q[0], q[1]])
        block[0] -= q[0]
        q[0] = 0
      else
        block[1] = q[1]
        q[0] -= block[0]
      end
      i += 1
    end
  end

  sig { void }
  def debug
    puts @disk.map { |size, val| (val || '.').to_s * size }.join
  end

  sig { returns(Integer) }
  def checksum
    res = 0
    i = 0
    @disk.each do |size, val|
      res += val * ((i + i + size - 1) * size) / 2 if val
      i += size
    end
    res
  end

  sig { void }
  def fill2!
    i = @disk.size - 1
    while i >= 0
      to_insert = T.must(@disk[i])
      next i -= 1 if to_insert[1].nil?

      insert_at = (0...i).find do |j|
        block = T.must(@disk[j])
        block[1].nil? && block[0] >= to_insert[0]
      end
      next i -= 1 if insert_at.nil?

      block = T.must(@disk[insert_at])
      @disk.insert(insert_at + 1, [block[0] - to_insert[0], nil]) if block[0] > to_insert[0]
      block[0] = to_insert[0]
      block[1] = to_insert[1]
      to_insert[1] = nil
      i -= 1
    end
  end

  sig { returns(Integer) }
  def part1
    fill!
    checksum
  end

  sig { returns(Integer) }
  def part2
    fill2!
    checksum
  end
end
