class Stream
  def initialize(input)
    @input = input
    while @input.gsub!(/([^!]|^)\!./, '\1'); end
  end

  def part1
    while @input.gsub!(/<[^>]+>/, ''); end
    level = 0
    sum = 0
    @input.each_char do |c|
      if c == '{'
        level += 1
        sum += level
      end
      if c == '}'
        level -= 1
      end
    end
    sum
  end

  def part2
    c = 0
    @input.gsub!(/<([^>]+)>/) { |m| c += m.size - 2 }
    c
  end
end
