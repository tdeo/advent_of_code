class NiceStrings
  def initialize(input)
    @strings = input.split("\n")
  end

  def nice?(string)
    string.tr('^aeiou', '').size >= 3 &&
      string =~ /(.)\1/ &&
      !string.include?('ab') &&
      !string.include?('cd') &&
      !string.include?('pq') &&
      !string.include?('xy')
  end

  def part1
    @strings.count { |s| nice?(s) }
  end

  def nice2?(str)
    str =~ /(..).*\1/ &&
      str =~ /(.).\1/
  end

  def part2
    @strings.count { |s| nice2?(s) }
  end
end
