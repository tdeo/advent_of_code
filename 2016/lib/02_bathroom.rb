class Bathroom
  def initialize(input)
    @instructions = input.split("\n").map(&:strip)
    @grid = Hash.new { |h, k| h[k] = {} }
  end

  def apply!(move)
    case move
    when 'U'
      @i -= 1 if @grid[@i - 1][@j]
    when 'D'
      @i += 1 if @grid[@i + 1][@j]
    when 'L'
      @j -= 1 if @grid[@i][@j - 1]
    when 'R'
      @j += 1 if @grid[@i][@j + 1]
    else
    end
  end

  def current
    @grid[@i][@j].to_s
  end

  def part1
    @i = 1
    @j = 1
    (0..2).each do |i|
      (0..2).each do |j|
        @grid[i][j] = 1 + 3 * i + j
      end
    end
    solve
  end

  def solve
    code = ''
    @instructions.each do |l|
      l.each_char { |c| apply!(c) }
      code << current
    end
    code
  end

  def part2
    @i = 2
    @j = 0
    @grid[0] = { 2 => 1 }
    @grid[1] = { 1 => 2, 2 => 3, 3 => 4 }
    @grid[2] = { 0 => 5, 1 => 6,  2 => 8, 3 => 8, 4 => 9 }
    @grid[3] = { 1 => 'A', 2 => 'B', 3 => 'C' }
    @grid[4] = { 2 => 'D' }
    solve
  end
end
