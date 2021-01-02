# frozen_string_literal: true

class DragonChecksum
  def initialize(input)
    @a = input.strip
  end

  def step!
    @a = [
      @a,
      '0',
      @a.dup.reverse.tr!('10', '01'),
    ].join
  end

  def checksum
    @checksum = @a.dup
    @checksum = @checksum.chars.each_slice(2).map { |s| s[0] == s[1] ? '1' : '0' }.join while @checksum.size.even?
    @checksum
  end

  def expand!
    step! while @a.size < @size
    @a = @a[0...@size]
  end

  def demo
    @size = 20
    expand!
    checksum
  end

  def part1
    @size = 272
    expand!
    checksum
  end

  def part2
    @size = 35_651_584
    expand!
    checksum
  end
end
