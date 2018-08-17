class ElectromagneticMoat
  def initialize(input)
    @bridges = Hash.new { |h, k| h[k] = [] }
    input.split("\n").each_with_index do |line, i|
      a, b = line.split('/').map(&:to_i)
      @bridges[a] << { to: b, idx: i, score: a + b }
      @bridges[b] << { to: a, idx: i, score: a + b }
    end
  end

  def highest_score(used, start)
    @bridges[start].map do |bridge|
      next if used.include?(bridge[:idx])
      bridge[:score] + highest_score(used + [bridge[:idx]], bridge[:to])
    end.compact.max || 0
  end

  def part1
    highest_score([], 0)
  end

  def longest_highest_score(used, start)
    @bridges[start].map do |bridge|
      next if used.include?(bridge[:idx])
      rest = longest_highest_score(used + [bridge[:idx]], bridge[:to])
      [rest[0] + 1, bridge[:score] + rest[1]]
    end.compact.sort.last || [0, 0]
  end

  def part2
    longest_highest_score([], 0)[1]
  end
end
