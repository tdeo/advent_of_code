class FireHazard
  def initialize(input)
    @lights = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = 0 }}
    @instructions = input.split("\n")
  end

  def apply!(ins)
    case
    when ins =~ /turn on (\d+),(\d+) through (\d+),(\d+)/
      ($1..$3).each do |i|
        ($2..$4).each do |j|
          @lights[i][j] = 1
        end
      end
    when ins =~ /toggle (\d+),(\d+) through (\d+),(\d+)/
      ($1..$3).each do |i|
        ($2..$4).each do |j|
          @lights[i][j] = 1 - @lights[i][j]
        end
      end
    when ins =~ /turn off (\d+),(\d+) through (\d+),(\d+)/
      ($1..$3).each do |i|
        ($2..$4).each do |j|
          @lights[i][j] = 0
        end
      end
    end
  end

  def part1
    @instructions.each { |ins| apply!(ins) }
    @lights.map { |_, v| v.count { |_, v2| v2 == 1 } }.reduce(:+)
  end

  def apply2!(ins)
    case
    when ins =~ /turn on (\d+),(\d+) through (\d+),(\d+)/
      ($1..$3).each do |i|
        ($2..$4).each do |j|
          @lights[i][j] += 1
        end
      end
    when ins =~ /toggle (\d+),(\d+) through (\d+),(\d+)/
      ($1..$3).each do |i|
        ($2..$4).each do |j|
          @lights[i][j] += 2
        end
      end
    when ins =~ /turn off (\d+),(\d+) through (\d+),(\d+)/
      ($1..$3).each do |i|
        ($2..$4).each do |j|
          @lights[i][j] -= 1 if @lights[i][j] > 0
        end
      end
    end
  end

  def part2
    @instructions.each { |ins| apply2!(ins) }
    @lights.map { |_, v| v.values.reduce(:+) }.reduce(:+)
  end
end
