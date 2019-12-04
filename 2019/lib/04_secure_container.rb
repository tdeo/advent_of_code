class SecureContainer
  def initialize(input)
    @input = input
    @s, @e = input.split('-').map(&:to_i)
  end

  def part1
    c = 0
    (@s..@e).each do |i|
      next unless i.to_s =~ /(\d)\1/
      next unless i.to_s.chars.each_cons(2).all? { |a, b| a.to_i <= b.to_i }
      c += 1
    end
    c
  end

  def part2
    count = 0
    (@s..@e).each do |i|
      next unless ('.' + i.to_s + '.').chars.each_cons(4).any? { |a, b, c, d|
        b == c && a != b && c != d
      }
      next unless i.to_s.chars.each_cons(2).all? { |a, b| a.to_i <= b.to_i }
      count += 1
    end
    count
  end
end
