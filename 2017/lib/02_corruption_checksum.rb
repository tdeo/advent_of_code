class CorruptionChecksum
  def initialize(input)
    @matrix = input.split("\n").map do |row|
      row.split(' ').map(&:strip).reject(&:empty?).map(&:to_i)
    end
  end

  def max_min(row)
    row.max - row.min
  end

  def division(row)
    (0...row.size).each do |i|
      (0...row.size).each do |j|
        next if i == j
        return row[i] / row[j] if row[i] % row[j] == 0
      end
    end
  end

  def part1
    @matrix.map { |r| max_min(r) }.reduce(0, :+)
  end

  def part2
    @matrix.map { |r| division(r) }.reduce(0, :+)
  end
end
