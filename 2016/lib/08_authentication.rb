class Authentication
  def initialize(input, rows = 6, cols = 50)
    @instructions = input.strip.split("\n").map(&:strip)
    @rows = rows
    @cols = cols
    @grid = @rows.times.map { @cols.times.map { 0 } }
  end

  def apply!(instruction)
    case instruction
    when /^rect/
      m = /^rect (\d+)x(\d+)$/.match(instruction)
      (0...m[2].to_i).each do |i|
        (0...m[1].to_i).each do |j|
          @grid[i][j] = 1
        end
      end
    when /^rotate row/
      m = /^rotate row y=(\d+) by (\d+)/.match(instruction)
      i = m[1].to_i
      rot = m[2].to_i
      copy = []
      (0...@cols).each do |j|
        copy[j] = @grid[i][(j - rot) % @cols]
      end
      @grid[i] = copy
    when /^rotate column/
      m = /^rotate column x=(\d+) by (\d+)/.match(instruction)
      j = m[1].to_i
      rot = m[2].to_i
      copy = []
      (0...@rows).each do |i|
        copy[i] = @grid[(i - rot) % @rows][j]
      end
      (0...@rows).each do |i|
        @grid[i][j] = copy[i]
      end
    end
  end

  def part1
    @instructions.each { |ins| apply!(ins) }
    @grid.flat_map(&:dup).reduce(0, :+)
  end

  def part2
    @instructions.each { |ins| apply!(ins) }
    @grid.each do |r|
      puts r.map { |i| i == 0 ? ' ' : '0' }.join
    end
    nil
  end
end
