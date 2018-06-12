class DragonChecksum
  def initialize(input)
    @a = input.strip
  end

  def step!
    @a = @a + '0' + @a.dup.reverse.tr!('10','01')
  end

  def checksum
    @checksum = @a.dup
    while @checksum.size % 2 == 0
      @checksum = @checksum.chars.each_slice(2).map { |s| s[0] == s[1] ? '1' : '0' }.join
    end
    @checksum
  end

  def expand!
    while @a.size < @size
      step!
    end
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
    @size = 35651584
    expand!
    checksum
  end
end
