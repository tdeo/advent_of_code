# frozen_string_literal: true

require 'digest'

class OneTimePad
  def initialize(input)
    @salt = input.strip
    @triplet = {}
    @quintuplets = Hash.new { |h, k| h[k] = Set.new }
  end

  def store_hash!(idx, h = Digest::MD5.hexdigest(@salt + idx.to_s))
    @triplet[idx] = h.match(/(.)\1\1/)&.send(:[], 1)
    h.scan(/(.)\1\1\1\1/).each { |m| @quintuplets[idx] << m[0] }
  end

  def key?(idx)
    @triplet[idx] && ((idx + 1)..(idx + 1000)).any? { |i| @quintuplets[i].include?(@triplet[idx]) }
  end

  def hash2(idx)
    res = @salt + idx.to_s
    2017.times { res = Digest::MD5.hexdigest(res) }
    res
  end

  def part1
    found = 0
    idx = -1
    1001.times { |i| store_hash!(i) }
    while found < 64
      idx += 1
      store_hash!(idx + 1000)
      found += 1 if key?(idx)
    end
    idx
  end

  def part2
    # This is slow but not that bad
    found = 0
    idx = -1
    1001.times { |i| store_hash!(i, hash2(i)) }
    while found < 64
      idx += 1
      store_hash!(idx + 1000, hash2(idx + 1000))
      found += 1 if key?(idx)
    end
    idx
  end
end
